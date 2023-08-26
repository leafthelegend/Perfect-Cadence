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
    var bpmGetter: BPMGetter
    var bpms = [String:Double?]()
    init(bpmGetter: BPMGetter){
        self.DJ = NextSongModel(bpmGetter: bpmGetter)
        self.bpmGetter = bpmGetter
        Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { timer in
                        print("Current cadence: \(self.paceTracker.cadence ?? 0.0)")
                        self.setSpeed(targetBPM: self.paceTracker.cadence ?? 0.0)
                        self.updateSpeed()
                    }
    }
//    private var currentSongId = "";
    
//    var tracks: [Track] = []
    
//    private var alert: AlertItem? = nil
    
//    @Published var searchText = ""
//    private var searchCancellable: AnyCancellable? = nil
//    private var infoCancellable: AnyCancellable? = nil
    func loadSongs() {
        musicPlayer.setQueue(with: .songs())
        musicPlayer.play()
        //loop through and get the song titles
        //default check 20 songs
        for _ in (1...20)
        {
            if let title = musicPlayer.nowPlayingItem?.title{
                titles.insert(title)
                
            }
            musicPlayer.skipToNextItem()
        }
        print("titles: \(titles)")
        musicPlayer.pause()
        musicPlayer.skipToBeginning()
        
        titleArray = Array(titles)
//        get the BPMs
//        let waiterGroup = DispatchGroup()
        print("about to start")
        bpmGetter.getBPMs(queries: titleArray, categories: [.track]){bpmDictionary in
            self.bpms = bpmDictionary
            print("BPMs: \(self.bpms)")
        }

    }
    func play() {
        musicPlayer.play()
        let query = MPMediaQuery.songs()
        print("query: \(query)")
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
        self.speed = max(targetBPM*60/Float(currentBaseBPM),0.5)
    }
    func updateSpeed() {
        musicPlayer.currentPlaybackRate = speed;
    }
    func updateQueue(){
        //choose the next song based on the DJ's choice
        let choice = DJ.nextSong(songNames: titleArray, playlist: bpms)
        print("\(choice)")
    }
//    func search(spotify: Spotify) {
//
//        self.tracks = []
//
//        if self.searchText.isEmpty { return }
//
//        print("searching with query '\(self.searchText)'")
//        self.isSearching = true
//
//        self.searchCancellable = spotify.api.search(
//            query: self.searchText, categories: [.track]
//        )
//        .receive(on: RunLoop.main)
//        .sink(
//            receiveCompletion: { completion in
//                self.isSearching = false
//                if case .failure(let error) = completion {
//                    self.alert = AlertItem(
//                        title: "Couldn't Perform Search",
//                        message: error.localizedDescription
//                    )
//                    print("error: \(error)")
//                }
//            },
//            receiveValue: { searchResults in
//                self.tracks = searchResults.tracks?.items ?? []
//                print("received \(self.tracks.count) tracks")
//                print("First track: \(self.tracks[0])")
//                print("ID: \(self.tracks[0].uri ?? "")")
//                self.currentSongId = self.tracks[0].uri ?? "";
//                self.getCurrentBPM(spotify: spotify)
//            }
//        )
//    }
//    func getCurrentBPM(spotify: Spotify){
//        self.infoCancellable = spotify.api.trackAudioFeatures(self.currentSongId)
//            .receive(on: RunLoop.main)
//            .sink(
//                receiveCompletion: { completion in
//                    if case .failure(let error) = completion {
//                        self.alert = AlertItem(
//                            title: "Couldn't Perform Feature Request",
//                            message: error.localizedDescription
//                        )
//                        print("error: \(error)")
//                    }
//                },
//                receiveValue: { features in
//                    print("features: \(features)")
//                    self.currentBaseBPM = features.tempo
//                    print("BPM: \(self.currentBaseBPM)")
//                }
//            )
//    }
    //    func playAVAudio(){do {
    //        guard let soundFileURL = Bundle.main.url(
    //                forResource: "sound effect",
    //                withExtension: "mp3"
    //        ) else{
    //            throw MyError.runtimeError("File not found")
    //        }
    //        // Configure and activate the AVAudioSession
    //        try AVAudioSession.sharedInstance().setCategory(
    //            AVAudioSession.Category.playback
    //        )
    //
    //        try AVAudioSession.sharedInstance().setActive(true)
    //
    //        // Play a sound
    //        let player = try AVAudioPlayer(
    //            contentsOf: soundFileURL
    //        )
    //
    //        player.play()
    //    }
    //        catch {
    //            // Handle error
    //        }
    //
    //    }
//    func oneSong () -> (URL?, String?) {
//        print("yote")
//        let query = MPMediaQuery.songs()
//        print("\(query)")
//        // always need to filter out songs that aren't present
//        let isPresent = MPMediaPropertyPredicate(value:false,
//            forProperty:MPMediaItemPropertyIsCloudItem,
//            comparisonType:.equalTo)
//        query.addFilterPredicate(isPresent)
//        let item = query.items?[0]
//        print("\(item?.hasProtectedAsset)")
//        return (item?.assetURL, item?.title)
//    }
//    @IBAction func doPlayOneSongAVPlayer (_ sender: Any) {
//        print("yeet")
//        let (url, title) = self.oneSong()
//        print("\(url),\(title)")
//        if let url = url, let title = title {
//            self.searchText = title
//            print("\(self.searchText)")
//            self.avplayer = AVPlayer(url:url)
//            print("\(self.avplayer)")
//            print("\(self.avplayer.status)")
//            print("\(self.avplayer.error)")
//            self.avplayer.play()
//            print("\(self.avplayer.status)")
//            MPNowPlayingInfoCenter.default().nowPlayingInfo = [
//                MPMediaItemPropertyTitle : title
//            ]
//            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
//                print("running timer: \(self.paceTracker.cadence ?? 0.0)")
//                self.setSpeed(targetBPM: self.paceTracker.cadence ?? 0.0)
//                self.updateSpeed()
//            }
//        }
//    }
}
