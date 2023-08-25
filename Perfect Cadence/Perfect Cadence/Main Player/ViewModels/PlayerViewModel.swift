//
//  LoginViewModel.swift
//  Perfect Cadence
//
//  Created by Lief Lundmark-Aitcheson on 25/8/2023.
//

import Foundation
import MediaPlayer
import os

class PlayerViewModel: ObservableObject {
    let logger = Logger()
    @Published var speed: Float = 1.0
    @Published var musicPlayer = MPMusicPlayerApplicationController.applicationMusicPlayer
    func loadSongs() {
        musicPlayer.setQueue(with: .songs())
    }
    func play() {
        musicPlayer.play()
        let title = musicPlayer.nowPlayingItem?.title
        logger.info("\(title ?? "")")
    }
    func pause() {
        musicPlayer.pause()
    }
    func updateSpeed() {
        musicPlayer.currentPlaybackRate = speed;
    }
    }
