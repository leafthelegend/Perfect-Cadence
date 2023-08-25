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
            self.calculateStepsInLastMinute()
        }
    }
    
    func calculateStepsInLastMinute() {
        let endDate = Date()
        if var startDate = Calendar.current.date(byAdding: .minute, value: -1, to: endDate) {
            print(startDate)
            startDate = max(startTime, startDate)
            print(startTime)
            print(startDate)
            pedometer.queryPedometerData(from: startDate, to: endDate) { pedometerData, error in
                if let pedometerData = pedometerData {
                    let timeInterval = endDate.timeIntervalSince(startDate)
                    let stepsPerSecond = Double(pedometerData.numberOfSteps.intValue) / timeInterval
                    self.stepsPerMin = Int(stepsPerSecond * 60)
                }
            }
        }
    }
}
