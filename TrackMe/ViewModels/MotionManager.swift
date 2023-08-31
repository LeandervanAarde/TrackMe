//
//  MotionManager.swift
//  TrackMe
//
//  Created by Leander Van Aarde on 31/08/2023.
//

import Foundation
import CoreMotion

class MotionManager: ObservableObject {
    private var motionManager = CMMotionManager()
    @Published var deviceOrientation: Double = 0.0
    
    init() {
        self.motionManager.deviceMotionUpdateInterval = 0.1
        self.motionManager.startDeviceMotionUpdates(to: .main) { data, error in
            if let orientation = data?.attitude {
                self.deviceOrientation = orientation.yaw
            }
        }
    }
}
