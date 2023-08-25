//
//  ContentView.swift
//  Perfect Cadence
//
//  Created by Lief Lundmark-Aitcheson on 25/8/2023.
//

import SwiftUI
import MediaPlayer

struct ContentView: View {
    @State var speed: Float = 1.0;
    @State var isEditing = false;
    let musicPlayer = MPMusicPlayerApplicationController.applicationMusicPlayer
    var body: some View {
        Button {
            musicPlayer.setQueue(with: .songs())
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
            musicPlayer.play()
        } label: {
            Text("Play")
                .fontWeight(.bold)
                .font(.system(.title, design: .rounded))
                .padding(20)
                .background(Color.purple)
                .foregroundColor(Color.white)
                .cornerRadius(20)
        }
        Button {
            musicPlayer.pause()
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
                    value: $speed,
                    in: 0...2,
                    onEditingChanged: { editing in
                        isEditing = editing
                        musicPlayer.currentPlaybackRate = speed;
                    }
                )
                Text("Playback speed \(speed)")
                    .foregroundColor(isEditing ? .red : .blue)
            }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
