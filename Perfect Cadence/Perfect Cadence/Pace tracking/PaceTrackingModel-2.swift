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
    @Published var cadence: Float = 0.0
    
    init() {
        startUpdating()
    }
    
    func startUpdating() {
        if CMPedometer.isCadenceAvailable() {
            pedometer.startUpdates(from: Date()) { [weak self] data, error in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error updating cadence: \(error)")
                    return
                }
                
                if let data = data {
                    DispatchQueue.main.async {
                        self.cadence = data.currentCadence?.floatValue ?? 0.0
                    }
                }
            }
        } else {
            print("Cadence isn't available.")
        }
    }
        
    func stopUpdating() {
        pedometer.stopUpdates()
    }
}
