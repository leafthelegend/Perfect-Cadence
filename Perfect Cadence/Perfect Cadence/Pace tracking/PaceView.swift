//
//  ContentView.swift
//  Perfect Cadence
//
//  Created by Ella WANG on 26/8/2023.
//

import SwiftUI
import CoreMotion

struct PaceView: View {
    
    @ObservedObject var stepTracker = StepTrackingModel()
    
    @ObservedObject var accelerationTracker = AccelerationTrackingModel()
    
    @ObservedObject var paceTracker = PaceTrackingModel()

    private let pedometer = CMPedometer()
    var body: some View {
        VStack {
            Text("Step Count:")
                .font(.headline)
            Text("\(stepTracker.stepCount)")
                .font(.largeTitle)
                .padding()
                        
            Text("Acceleration:")
                .font(.headline)
            Text("\(accelerationTracker.runningAcceleration, specifier: "%.2f") m/s^2")
                .font(.largeTitle)
                .padding()
            
            Text("Running Pace:")
                .font(.headline)
            Text("\(paceTracker.cadence ?? 0.0)")
                .font(.largeTitle)
                .padding()

        }
    }
}

struct PaceView_Previews: PreviewProvider {
    static var previews: some View {
        PaceView()
    }
}
