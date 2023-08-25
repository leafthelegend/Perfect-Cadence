//
//  ContentView.swift
//  Perfect Cadence
//
//  Created by Ella WANG on 26/8/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var pedometerWrapper = PedometerWrapper()

    var body: some View {
        VStack {
            Text("Step Count:")
                .font(.headline)
            Text("\(pedometerWrapper.stepCount)")
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
