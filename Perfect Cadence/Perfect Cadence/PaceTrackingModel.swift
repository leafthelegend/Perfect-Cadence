//
//  PaceTrackingModel.swift
//  Perfect Cadence
//
//  Created by Ella WANG on 26/8/2023.
//

import Foundation
import CoreMotion

class PaceTrackingModel: ObservableObject {
    private let pedometer = CMPedometer()
    private let startTime = Date()
    @Published var stepsPerMin: Int = 0
    
    init() {
        startUpdating()
    }
    
    func startUpdating() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.calculatePace()
        }
    }
    
    // Taking the avg stepsPerMin over the interval of 13s
    // TODO -- find the best interval (the update lags -> oscillates)
    // Optional -- heartbeat if we can convince Garmin to work w/ apple :3
    func calculatePace() {
        let endDate = Date()
        if let startDate = Calendar.current.date(byAdding: .second, value: -13, to: endDate) {
            pedometer.queryPedometerData(from: startDate, to: endDate) { pedometerData, error in
                if let pedometerData = pedometerData {
                    let timeInterval = endDate.timeIntervalSince(max(self.startTime, startDate))
                    let stepsPerSec = Double(pedometerData.numberOfSteps.intValue) / timeInterval
                    self.stepsPerMin = Int(stepsPerSec * 60)
                }
            }
        }
    }
}
