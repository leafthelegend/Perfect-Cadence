//
//  GetBPMView.swift
//  Perfect Cadence
//
//  Created by Lief Lundmark-Aitcheson on 26/8/2023.
//

import Foundation
import SwiftUI
import Combine

struct GetBPMView: View {
    
    @EnvironmentObject var spotify: Spotify
    @ObservedObject var viewModel: BPMViewModel = BPMViewModel()
    
    @State private var cancellables: Set<AnyCancellable> = []
    @State private var songName: String = ""
    @State private var bpm: Int? = 0;

    var body: some View {
        List {
            TextField(
                    "Song title",
                    text: $songName
            ).onSubmit{
                bpm = viewModel.searchBPM(title: songName, api: spotify)
            }
            Text("\(bpm ?? 0)")
            Button("Print SpotifyAPI") {
                print(
                    """
                    --- SpotifyAPI ---
                    \(self.spotify.api)
                    ------------------
                    """
                )
            }
            
        }
        .navigationBarTitle("Get BPM of Song")
    }
}

struct GetBPMView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GetBPMView()
        }
        .environmentObject(Spotify())
    }
}
