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
        let BPMGetter = BPMGetter()
        BPMGetter.getBPMs(queries: ["Snowblind","Beat It", "Blinding Lights"], categories: [.track]){result in
            print("\(result)")   
        }
        BPMGetter.getBPM(title:"Snowblind"){bpm in
            print("BPM \(bpm)")
        }
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(spotify)
        }
    }
}
