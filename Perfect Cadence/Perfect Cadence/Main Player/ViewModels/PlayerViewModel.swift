//
//  PlayerViewModel.swift
//  Perfect Cadence
//
//  Created by Lief Lundmark-Aitcheson on 25/8/2023.
//
import Foundation
import MediaPlayer
import os
import SpotifyWebAPI
import Combine
import AVFoundation
import AVFAudio

enum MyError: Error {
    case runtimeError(String)
}

enum CONSTANTS {
    static let CHANGE_THRESHOLD : Double = 0.05;
    static let UPDATE_INTERVAL : Double = 10.0;
    static let MIN_MULTIPLIER : Float = 0.75;
}

class PlayerViewModel: ObservableObject {
    let logger = Logger()
    @Published var speed: Float = 1.0
    @Published var currentBPM: Double = 100.0
    @Published var baseBPM: Double = 100.0
    @Published var artwork: MPMediaItemArtwork? = nil;
    var musicPlayer = MPMusicPlayerApplicationController.applicationMusicPlayer
    var paceTracker = PaceTrackingModel()
    var DJ: NextSongModel
    var titles = Set<String>()
    var titleArray = [String]()
    var songs = [String:MPMediaItem]()
    var bpmGetter: BPMGetter
    var bpms = [String:Double?]()
    var isPaused: Bool = true;
    var matchingTarget: Bool = true;
    var bpmTarget: Float = 130.0/60.0;
    init(bpmGetter: BPMGetter){
        print("Init")
        self.DJ = NextSongModel(bpmGetter: bpmGetter)
        self.bpmGetter = bpmGetter
        loadSongs()
        Timer.scheduledTimer(withTimeInterval: CONSTANTS.UPDATE_INTERVAL, repeats: true) { timer in
                        print("Current cadence: \(self.paceTracker.cadence)")
                        self.reflow()
                    }
    }
    func reflow(){
        self.setSpeed(targetBPM: self.paceTracker.cadence)
        self.updateSpeed()
        self.updateQueue()
    }
    func loadSongs() {
        musicPlayer.setQueue(with: .songs())
        musicPlayer.beginGeneratingPlaybackNotifications()
        musicPlayer.play()
        //loop through and get the song titles
        //default check 20 songs
        for _ in (1...20)
        {
            if let song = musicPlayer.nowPlayingItem, let title = song.title{
                if titleArray.contains(title){break}
                titleArray.append(title)
                songs[title] = song
            }
            musicPlayer.skipToNextItem()
        }
        print("titles: \(titleArray)")
        musicPlayer.pause()
        musicPlayer.skipToBeginning()
        
//        get the BPMs
        let waiterGroup = DispatchGroup()
        waiterGroup.enter()
        print("about to start")
        bpmGetter.getBPMs(queries: titleArray, categories: [.track]){bpmDictionary in
            self.bpms = bpmDictionary
            print("BPMs: \(self.bpms)")
            waiterGroup.leave()
        }
        waiterGroup.notify(queue: .main){
            self.DJ.clearHistory()
        }
        let ns = NotificationCenter.default
        ns.addObserver(
            forName: Notification.Name.MPMusicPlayerControllerNowPlayingItemDidChange,
            object: musicPlayer,
            queue: nil
        ){ (notification) in
            if let title = self.musicPlayer.nowPlayingItem?.title, let artwork = self.musicPlayer.nowPlayingItem?.artwork{
                self.DJ.pushSong(title: title)
                self.artwork = artwork
                print("Detected song Change!")
                self.setSpeed(targetBPM: self.paceTracker.cadence)
                self.updateSpeed()
                self.updateQueue()
            }
        }
    }
    func scheduleNext(title: String){
        if let song = songs[title]{
            let id = song.playbackStoreID
            let descriptor = MPMusicPlayerStoreQueueDescriptor(storeIDs: [id])
            print("id: \(id)")
            print("descriptor: \(descriptor)")
            musicPlayer.prepend(descriptor)
        }else{
            print("Invalid title")
        }
    }
    func play() {
        print("Pause")
        musicPlayer.play()
        self.artwork = musicPlayer.nowPlayingItem?.artwork
        self.isPaused = false;
    }
    func skip(){
        musicPlayer.skipToNextItem()
    }
    func pause() {
        print("Pause")
        musicPlayer.pause()
        self.isPaused = true;
    }
    func setSpeed(targetBPM: Float){
        if let title = musicPlayer.nowPlayingItem?.title{if let baseBPM = bpms[title]{
            var target = targetBPM
            if matchingTarget{
                target = bpmTarget
            }
            let speedOptions = [
                max(target*120/Float(baseBPM ?? 100),CONSTANTS.MIN_MULTIPLIER),
                max(target*30/Float(baseBPM ?? 100),CONSTANTS.MIN_MULTIPLIER),
                max(target*60/Float(baseBPM ?? 100),CONSTANTS.MIN_MULTIPLIER)
            ]
            let sortedSpeeds = speedOptions.sorted {
                abs($0 - 1.0) > abs($1 - 1.0)
            }
            self.speed = sortedSpeeds[2]
            self.baseBPM = baseBPM ?? 100.0
            self.currentBPM = Double(sortedSpeeds[2])*(baseBPM ?? 100.0)
            print("Speed: \(self.speed)")
        }}
    }
    func updateSpeed() {
        if isPaused{return}
        if (Double(abs(self.speed - musicPlayer.currentPlaybackRate)) > CONSTANTS.CHANGE_THRESHOLD) || matchingTarget {
            print("Updated Speed! Threshold: \(abs(self.speed - musicPlayer.currentPlaybackRate))")
            musicPlayer.currentPlaybackRate = speed;
        }else{
            
        }
    }
    func updateQueue(){
        if isPaused{return}
        //choose the next song based on the DJ's choice
        if let choice = DJ.nextSong(songNames: titleArray, playlist: bpms, cadence: Double(paceTracker.cadence)){
            scheduleNext(title: choice)
            print("Up next: \(choice)")
        }
    }
}
