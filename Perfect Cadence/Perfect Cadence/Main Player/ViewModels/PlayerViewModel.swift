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

class PlayerViewModel: ObservableObject {
    let logger = Logger()
    @Published var speed: Float = 1.0
    @Published var musicPlayer = MPMusicPlayerApplicationController.applicationMusicPlayer
    
    @Published var isSearching = false
    @Published var currentBaseBPM = 0.0
    private var currentSongId = "";
    
    var tracks: [Track] = []

    private var alert: AlertItem? = nil
    
    @Published var searchText = ""
    private var searchCancellable: AnyCancellable? = nil
    private var infoCancellable: AnyCancellable? = nil
    func loadSongs() {
        musicPlayer.setQueue(with: .songs())
    }
    func play() {
        musicPlayer.play()
        let title = musicPlayer.nowPlayingItem?.title
        self.searchText = title ?? ""
        logger.info("\(title ?? "")")
    }
    func pause() {
        musicPlayer.pause()
    }
    func setSpeed(targetBPM: Float){
        self.speed = targetBPM/Float(currentBaseBPM)
    }
    func updateSpeed() {
        musicPlayer.currentPlaybackRate = speed;
    }
    func search(spotify: Spotify) {

        self.tracks = []
        
        if self.searchText.isEmpty { return }

        print("searching with query '\(self.searchText)'")
        self.isSearching = true
        
        self.searchCancellable = spotify.api.search(
            query: self.searchText, categories: [.track]
        )
        .receive(on: RunLoop.main)
        .sink(
            receiveCompletion: { completion in
                self.isSearching = false
                if case .failure(let error) = completion {
                    self.alert = AlertItem(
                        title: "Couldn't Perform Search",
                        message: error.localizedDescription
                    )
                    print("error: \(error)")
                }
            },
            receiveValue: { searchResults in
                self.tracks = searchResults.tracks?.items ?? []
                print("received \(self.tracks.count) tracks")
                print("First track: \(self.tracks[0])")
                print("ID: \(self.tracks[0].uri ?? "")")
                self.currentSongId = self.tracks[0].uri ?? "";
                self.getCurrentBPM(spotify: spotify)
            }
        )
    }
    func getCurrentBPM(spotify: Spotify){
        self.infoCancellable = spotify.api.trackAudioFeatures(self.currentSongId)
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.alert = AlertItem(
                        title: "Couldn't Perform Feature Request",
                        message: error.localizedDescription
                    )
                    print("error: \(error)")
                }
            },
            receiveValue: { features in
                print("features: \(features)")
                self.currentBaseBPM = features.tempo
                print("BPM: \(self.currentBaseBPM)")
            }
        )
    }
    }
