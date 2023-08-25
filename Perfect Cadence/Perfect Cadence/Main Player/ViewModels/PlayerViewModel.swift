//
//  LoginViewModel.swift
//  Perfect Cadence
//
//  Created by Lief Lundmark-Aitcheson on 25/8/2023.
//

import Foundation
import MediaPlayer

class PlayerViewModel: ObservableObject {

    @Published var speed: Float = 1.0
    @Published var musicPlayer = MPMusicPlayerApplicationController.applicationMusicPlayer
    func loadSongs() {
        musicPlayer.setQueue(with: .songs())
    }
    func play() {
        musicPlayer.play()
    }
    func pause() {
        musicPlayer.pause()
    }
    func updateSpeed() {
        musicPlayer.currentPlaybackRate = speed;
    }
    }
