//
//  Smart_LightApp.swift
//  Smart Light
//
//  Created by Ricky Vishwas on 20/11/25.
//

import SwiftUI
import FirebaseCore

@main
struct Smart_LightApp: App {
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView(
                viewModel: SmartLightViewModel(deviceId: "Smart Light")
            )
        }
    }
}
