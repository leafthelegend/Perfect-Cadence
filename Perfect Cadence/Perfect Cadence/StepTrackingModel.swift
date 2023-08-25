//
//  MotionTrackingModel.swift
//  Perfect Cadence
//
//  Created by Ella WANG on 26/8/2023.
//

import Foundation
import CoreMotion

// tracks number of steps
class StepTrackingModel: ObservableObject {
    private var pedometer = CMPedometer()
    @Published var stepCount: Int = 0

    init() {
        startTrackingSteps()
    }

    func startTrackingSteps() {
        if CMPedometer.isStepCountingAvailable() {
            pedometer.startUpdates(from: Date()) { pedometerData, error in
                if let error = error {
                            print("Error requesting authorization: \(error)")
                } else if let pedometerData = pedometerData {
                    DispatchQueue.main.async {
                        self.stepCount = pedometerData.numberOfSteps.intValue
                    }
                }
            }
        }
    }
}

