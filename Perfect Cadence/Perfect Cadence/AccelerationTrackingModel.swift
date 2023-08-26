//
//  PaceTrackingModel.swift
//  Perfect Cadence
//
//  Created by Ella WANG on 26/8/2023.
//

import Foundation
import CoreMotion


// tracks the speed (but tracking acceleration & inaccurate ATM)
// issue -- CMOdometerData -> speed is in Beta BRUHHHH
// speed(t_i) = speed(t_i-1) + acceleration(t_i) * (t_i - t_i-1)
// speed = integrate(a)
// do we acc need speed?
class AccelerationTrackingModel: ObservableObject {
    private let motionManager = CMMotionManager()
    @Published var runningAcceleration: Double = 0.0

    init() {
        startTrackingPace()
    }

    func startTrackingPace() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.1
            motionManager.startAccelerometerUpdates(to: .main) { accelerometerData, error in
                if let accelerometerData = accelerometerData {
                    self.runningAcceleration = self.calculatePace(acceleration: accelerometerData.acceleration)
                }
            }
        }
    }

    // wrong calculation but why
    private func calculatePace(acceleration: CMAcceleration) -> Double {
        return sqrt(acceleration.x * acceleration.x + acceleration.y * acceleration.y + acceleration.z * acceleration.z)
    }
}






