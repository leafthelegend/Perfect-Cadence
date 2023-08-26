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
    @Published var cadence: Float? = 0.0
    
    init() {
        startUpdating()
        print(CMPedometer.isCadenceAvailable())
    }
    
    func startUpdating() {
        pedometer.startUpdates(
            from : Date(),
            withHandler: { data, error in
                self.cadence = data?.currentCadence?.floatValue
            }
        )
    }
}
