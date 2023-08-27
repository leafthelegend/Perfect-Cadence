//
//  LoginViewModel.swift
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
}

class PlayerViewModel: ObservableObject {
    let logger = Logger()
    @Published var speed: Float = 1.0
    @Published var musicPlayer = MPMusicPlayerApplicationController.applicationMusicPlayer
//    var avplayer : AVPlayer = AVPlayer()
//    @Published var isSearching = false
    @Published var currentBaseBPM = 0.0
    var paceTracker = PaceTrackingModel()
    var DJ: NextSongModel
    var titles = Set<String>()
    var titleArray = [String]()
    var songs = [String:MPMediaItem]()
    var bpmGetter: BPMGetter
    var bpms = [String:Double?]()
    init(bpmGetter: BPMGetter){
        self.DJ = NextSongModel(bpmGetter: bpmGetter)
        self.bpmGetter = bpmGetter
        musicPlayer.beginGeneratingPlaybackNotifications()
        let ns = NotificationCenter.default
        ns.addObserver(
            forName: Notification.Name.MPMusicPlayerControllerNowPlayingItemDidChange,
            object: musicPlayer,
            queue: nil
        ){ (notification) in
            if let title = self.musicPlayer.nowPlayingItem?.title{
                self.DJ.pushSong(title: title)
                print("Detected song Change!")
            }
        }
        Timer.scheduledTimer(withTimeInterval: CONSTANTS.UPDATE_INTERVAL, repeats: true) { timer in
                        print("Current cadence: \(self.paceTracker.cadence ?? 0.0)")
                        self.setSpeed(targetBPM: self.paceTracker.cadence ?? 0.0)
                        self.updateSpeed()
                        self.updateQueue()
                    }
    }
    func loadSongs() {
        musicPlayer.setQueue(with: .songs())
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
//        let waiterGroup = DispatchGroup()
        print("about to start")
        bpmGetter.getBPMs(queries: titleArray, categories: [.track]){bpmDictionary in
            self.bpms = bpmDictionary
            print("BPMs: \(self.bpms)")
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
        musicPlayer.play()
//        let query = MPMediaQuery.songs()
//        print("query: \(query)")
        let title = musicPlayer.nowPlayingItem?.title
//        self.searchText = title ?? ""
        logger.info("\(title ?? "")")
    }
    func skip(){
        musicPlayer.skipToNextItem()
        let title = musicPlayer.nowPlayingItem?.title
//        self.searchText = title ?? ""
    }
    func pause() {
        musicPlayer.pause()
    }
    func setSpeed(targetBPM: Float){
        if let title = musicPlayer.nowPlayingItem?.title{if let baseBPM = bpms[title]{
//            print("baseBPM: \(baseBPM)")
            let speedOptions = [
                max(targetBPM*120/Float(baseBPM ?? 100),0.5),
                max(targetBPM*30/Float(baseBPM ?? 100),0.5),
                max(targetBPM*60/Float(baseBPM ?? 100),0.5)
            ]
            let sortedSpeeds = speedOptions.sorted {
                abs($0 - 1.0) > abs($1 - 1.0)
            }
            self.speed = sortedSpeeds[2]
            print("Speed: \(self.speed)")
        }}
    }
    func updateSpeed() {
        if Double(abs(self.speed - musicPlayer.currentPlaybackRate)) > CONSTANTS.CHANGE_THRESHOLD{
            print("Updated Speed! Threshold: \(abs(self.speed - musicPlayer.currentPlaybackRate))")
            musicPlayer.currentPlaybackRate = speed;
        }else{
            
        }
    }
    func updateQueue(){
        //choose the next song based on the DJ's choice
        if let choice = DJ.nextSong(songNames: titleArray, playlist: bpms){
            scheduleNext(title: choice)
            print("Up next: \(choice)")
        }
    }
}
