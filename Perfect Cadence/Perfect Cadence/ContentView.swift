//
//  ContentView.swift
//  Perfect Cadence
//
//  Created by Ella WANG on 26/8/2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var stepTracker = StepTrackingModel()
    
    @ObservedObject var paceTracker = PaceTrackingModel()

    var body: some View {
        VStack {
            Text("Step Count:")
                .font(.headline)
            Text("\(stepTracker.stepCount)")
                .font(.largeTitle)
                .padding()
                        
            Text("Running Pace:")
                .font(.headline)
            Text("\(paceTracker.runningPace, specifier: "%.2f") m/s")
                .font(.largeTitle)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
