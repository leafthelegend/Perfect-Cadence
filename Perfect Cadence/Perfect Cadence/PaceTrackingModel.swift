//
//  PaceTrackingModel.swift
//  Perfect Cadence
//
//  Created by Ella WANG on 26/8/2023.
//

import Foundation
import CoreMotion

// tracks the speed (but seems sus)
class PaceTrackingModel: ObservableObject {
    private let motionManager = CMMotionManager()
    @Published var runningPace: Double = 0.0

    init() {
        startTrackingPace()
    }

    func startTrackingPace() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 1.0
            motionManager.startAccelerometerUpdates(to: .main) { accelerometerData, error in
                if let accelerometerData = accelerometerData {
                    self.runningPace = self.calculatePace(acceleration: accelerometerData.acceleration)
                }
            }
        }
    }

    private func calculatePace(acceleration: CMAcceleration) -> Double {
        return sqrt(acceleration.x * acceleration.x + acceleration.y * acceleration.y + acceleration.z * acceleration.z)
    }
}




