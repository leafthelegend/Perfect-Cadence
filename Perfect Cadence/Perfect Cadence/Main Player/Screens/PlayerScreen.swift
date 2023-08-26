//
//  PlayerScreen.swift
//  Perfect Cadence
//
//  Created by Lief Lundmark-Aitcheson on 25/8/2023.
//

import Foundation
import SwiftUI
import Combine

struct PlayerScreen: View {
    @ObservedObject var viewModel: PlayerViewModel = PlayerViewModel()
    @EnvironmentObject var spotify: Spotify
    let playlistSelectionVC = PlaylistSelectionController()
    var body: some View {
//        Button {
//            playlistSelectionVC.selectPlaylistButtonTapped()
//        } label: {
//            Text("Select playlist")
//                .fontWeight(.bold)
//                .font(.system(.title, design: .rounded))
//                .padding(20)
//                .background(Color.purple)
//                .foregroundColor(Color.white)
//                .cornerRadius(20)
//        }
        
        Button {
            viewModel.loadSongs()
        } label: {
            Text("Load songs")
                .fontWeight(.bold)
                .font(.system(.title, design: .rounded))
                .padding(20)
                .background(Color.purple)
                .foregroundColor(Color.white)
                .cornerRadius(20)
        }
        Button {
            viewModel.play()
//            viewModel.search(spotify: spotify)
        } label: {
            Text("Play via MediaPlayer")
                .fontWeight(.bold)
                .font(.system(.title, design: .rounded))
                .padding(20)
                .background(Color.purple)
                .foregroundColor(Color.white)
                .cornerRadius(20)
        }
        Button {
            viewModel.skip()
//            viewModel.search(spotify: spotify)
        } label: {
            Text("Skip")
                .fontWeight(.bold)
                .font(.system(.title, design: .rounded))
                .padding(20)
                .background(Color.purple)
                .foregroundColor(Color.white)
                .cornerRadius(20)
        }
//        Button {
//            viewModel.search(spotify: spotify)
//        } label: {
//            Text("Play via AVAudio")
//                .fontWeight(.bold)
//                .font(.system(.title, design: .rounded))
//                .padding(20)
//                .background(Color.purple)
//                .foregroundColor(Color.white)
//                .cornerRadius(20)
//        }
        Button {
            viewModel.pause()
        } label: {
            Text("Pause")
                .fontWeight(.bold)
                .font(.system(.title, design: .rounded))
                .padding(20)
                .background(Color.purple)
                .foregroundColor(Color.white)
                .cornerRadius(20)
        }
        VStack {
                Slider(
                    value: $viewModel.speed,
                    in: 0...2,
                    onEditingChanged: { editing in
                        viewModel.updateSpeed()
                    }
                )
            Text("Playback speed \(viewModel.speed)")
            }

    }
}

struct PlayerScreen_Previews: PreviewProvider {
    static var previews: some View {
        PlayerScreen()
    }
}
