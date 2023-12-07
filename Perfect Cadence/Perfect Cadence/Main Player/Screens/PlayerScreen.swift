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
    
    @ObservedObject var stepTracker = StepTrackingModel()
    
    @ObservedObject var paceTracker = PaceTrackingModel()
    
    @ObservedObject var viewModel : PlayerViewModel
    
    @State var isPlaying = false
        
    @State private var gradient: LinearGradient = LinearGradient(
        gradient: Gradient(
            colors: [
                Color(red: Double.random(in: 0.0 ..< 1.0), green: Double.random(in: 0.0 ..< 1.0), blue: Double.random(in: 0.0 ..< 1.0)),
                Color(red: Double.random(in: 0.0 ..< 1.0), green: Double.random(in: 0.0 ..< 1.0), blue: Double.random(in: 0.0 ..< 1.0))
            ]
        ),
        startPoint: .leading, endPoint: .trailing
    )
    
    @State private var timer: Timer?
    @State private var bpmTarget: String = ""
    
    init(vm:PlayerViewModel){
        viewModel = vm
    }
    
    func generateRandomBackgroundGradient(speed: Double) -> LinearGradient {
        let red = Double.random(in: 0.0 ..< 1.0)
        let green = Double.random(in: 0.0 ..< 1.0)
        let blue = Double.random(in: 0.0 ..< 1.0)
        let color1 = Color(red: red, green: green, blue: blue)
        let color2 = Color(red: max(1, speed*red), green: max(1, speed*green), blue: max(1, speed*blue))
        
        return LinearGradient(
            gradient: Gradient(colors: [color1, color2]),
            startPoint: .leading,
            endPoint: .trailing
        )
        
    }
    
    func updateGradient() {
        gradient = generateRandomBackgroundGradient(speed: Double(viewModel.speed))
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
            updateGradient()
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
        
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                Toggle("Set Target", isOn: $viewModel.matchingTarget)
                    .padding().onSubmit {
                        viewModel.reflow()
                    }
                
                if viewModel.matchingTarget {
                    //                Text("Target: \(Int(viewModel.bpmTarget*60.0))")
                    //                    .font(.headline)
                    //                    .foregroundColor(.green)
                    TextField(
                        "Target BPM",
                        text: $bpmTarget                ).font(.headline).multilineTextAlignment(.center).foregroundColor(.green).onSubmit {
                            if let bpm = Int(bpmTarget){
                                viewModel.bpmTarget = Float(bpm)/60.0
                                viewModel.reflow()
                            }
                        }
                }else{
                    Text("Perfect Cadence will match your pace.")
                        .font(.headline)
                        .foregroundColor(.purple)
                }
                
                HStack {
                    
                    if let artwork = viewModel.artwork,
                       let uiImage = artwork.image(at: CGSize(width: 90, height: 90)) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 90, height: 90).padding(5)
                    } else {
                        Color.gray
                            .frame(width: 90, height: 90).padding(5)
                    }
                    
                    VStack {
                        Text(viewModel.musicPlayer.nowPlayingItem?.title ?? "No Title")
                            .fontWeight(.bold)
                            .font(.system(.headline, design: .rounded))
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
                            .font(.system(size: 60))
                    }
                    
                    Button {
                        viewModel.skip()
                    } label: {
                        Image(systemName: "forward.end.fill")
                            .font(.system(size: 27))
                    }
                }
                .padding(geometry.size.width * 0.05)
                .background(gradient.cornerRadius(30).shadow(radius: /*@START_MENU_TOKEN@*/20/*@END_MENU_TOKEN@*/))
                .onAppear {
                    startTimer()
                }
                .onDisappear {
                    stopTimer()
                }
                VStack {
                    Text("Base BPM:")
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.bold)
                    Text("\(Int(viewModel.baseBPM))")
                        .font(.system(.largeTitle))
                        .padding(geometry.size.height * 0.005)
                    
                    Text("Current BPM:")
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.bold)
                    Text("\(Int(Double(viewModel.speed) * Double(viewModel.baseBPM)))")
                        .font(.system(.largeTitle))
                        .padding(geometry.size.height * 0.005)
                    
                    Text("Step per Min:")
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.bold)
                    Text("\(Int(paceTracker.cadence * 60))")
                        .font(.system(.largeTitle))
                        .padding(geometry.size.height * 0.005)
                }
                .padding(.top, geometry.size.height * 0.05)
                Spacer()
            }
            .ignoresSafeArea()
        }
    }
    
}

struct PlayerScreen_Previews: PreviewProvider {
    static var previews: some View {
        let bpmGetter = BPMGetter()
        PlayerScreen().environmentObject(bpmGetter)
    }
}
