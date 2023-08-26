//
//  Perfect_CadenceApp.swift
//  Perfect Cadence
//
//  Created by Lief Lundmark-Aitcheson on 25/8/2023.
//

import SwiftUI
import MediaPlayer
import Combine
import SpotifyWebAPI

@main
struct Perfect_CadenceApp: App {
    @StateObject var spotify = Spotify()

    init() {
        SpotifyAPILogHandler.bootstrap()
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(spotify)
        }
    }
}
