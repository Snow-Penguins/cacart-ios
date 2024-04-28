//
//  ecommerce_snow_penguinsApp.swift
//  cacart-ios
//
//  Created by Derek Kim on 2024-04-23.
//

import SwiftUI

@main
struct ecommerce_snow_penguinsApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(AuthManager())
        }
    }
}
