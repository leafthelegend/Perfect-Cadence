//
//  PlayerScreen.swift
//  Perfect Cadence
//
//  Created by Lief Lundmark-Aitcheson on 25/8/2023.
//

import Foundation
import SwiftUI
import Combine
import CoreMotion



struct PlayerScreen: View {
//    @EnvironmentObject var spotify: Spotify
    
    @EnvironmentObject var bpmGetter: BPMGetter
    
//    @State var isPlaying = false
//
//    @ObservedObject var stepTracker = StepTrackingModel()
//
//    @ObservedObject var paceTracker = PaceTrackingModel()
    
//    @ObservedObject var viewModel : PlayerViewModel
    
    init(){
//        @ObservedObject var viewModel = PlayerViewModel(bpmGetter: bpmGetter)
    }
    

    
//    private let pedometer = CMPedometer()
//
//    let playlistSelectionVC = PlaylistSelectionController()
    
    
    var body: some View {
        InternalPlayerView(vm: PlayerViewModel(bpmGetter: bpmGetter))
    }
}

struct InternalPlayerView: View {
    @EnvironmentObject var spotify: Spotify
    
    @EnvironmentObject var bpmGetter: BPMGetter
    
    @State var isPlaying = false
    
    @ObservedObject var stepTracker = StepTrackingModel()
    
    @ObservedObject var paceTracker = PaceTrackingModel()
    
    @ObservedObject var viewModel : PlayerViewModel
    
    init(vm:PlayerViewModel){
        viewModel = vm
    }
    
    var body: some View {
        VStack {
            
            HStack {
                
                VStack {
                    Text(viewModel.musicPlayer.nowPlayingItem?.title ?? "No Title")
                        .fontWeight(.bold)
                        .font(.system(.title, design: .rounded))
                        .padding(4)
                    
                    Text(viewModel.musicPlayer.nowPlayingItem?.artist ?? "Unknown Artist")
                        .font(.subheadline)
                }
                Button {
                    isPlaying = !isPlaying
                    if isPlaying {
                        viewModel.play()
                    } else {
                        viewModel.pause()
                    }
                } label: {
                    Image(systemName: isPlaying ? "pause.circle" : "play.circle")
                        .font(.system(size: 100))
                }
                
                Button {
                    viewModel.skip()
                } label: {
                    Image(systemName: "forward.end.fill")
                        .font(.system(size: 40))
                }
            }.padding(50)
            
            Text("Base BPM:")
                .font(.system(.title, design: .rounded))
                .fontWeight(.bold)
            Text("\(Int(viewModel.baseBPM))")
                .font(.largeTitle)
                .padding()
            
            Text("Current BPM:")
                .font(.system(.title, design: .rounded))
                .fontWeight(.bold)
            Text("\(Int(Double(viewModel.speed) * Double(viewModel.baseBPM)))")
                .font(.largeTitle)
                .padding()
            
            Text("Step per Min:")
                .font(.system(.title, design: .rounded))
                .fontWeight(.bold)
            Text("\(Int(paceTracker.cadence * 60))")
                .font(.largeTitle)
                .padding()
        }
    }
    
}

struct PlayerScreen_Previews: PreviewProvider {
    static var previews: some View {
        let bpmGetter = BPMGetter()
        PlayerScreen().environmentObject(bpmGetter)
    }
}
