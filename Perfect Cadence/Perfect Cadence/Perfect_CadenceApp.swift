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
    @StateObject var bpmGetter = BPMGetter()
    init() {
        SpotifyAPILogHandler.bootstrap()
//        bpmGetter.getBPMs(queries: ["Eucalyptus complete 1", "Snowblind (feat. Tasha Baxter)", "MUZZ B2B TEDDY KILLERZ @ SANCTUM 2023", "Metrik B2B Grafix @ EDC Las Vegas 2023", "pls, no call (but HB)", "Summer Sunset", "Melancholy rising"], categories: [.track]){result in
//            print("initial bpms :\(result)")
//        }
//        BPMGetter.getBPM(title:"Snowblind"){bpm in
//            print("BPM \(bpm)")
//        }
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(spotify).environmentObject(bpmGetter)
        }
    }
}
