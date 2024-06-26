//
//  MainView.swift
//  ecommerce-snow-penguins
//
//  Created by Derek Kim on 2024-04-24.
//

import SwiftUI

struct MainView: View {
    // MARK: - Properties

    /// A temporary  manager to manage auth flow.
    @EnvironmentObject var authManager: AuthManager

    // MARK: - View Conformance

    var body: some View {
        Group {
            if authManager.isLoggedIn {
                ContentView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    MainView()
}
