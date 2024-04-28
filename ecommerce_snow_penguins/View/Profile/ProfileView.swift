//
//  ProfileView.swift
//  ecommerce-snow-penguins
//
//  Created by Derek Kim on 2024-04-24.
//

import SwiftUI

struct ProfileView: View {
    // MARK: - Properties

    /// A temporary  manager to manage auth flow.
    @EnvironmentObject var authManager: AuthManager

    // MARK: - View Conformance

    var body: some View {
        NavigationStack {
            VStack {
                Text("Profile Page")
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        authManager.logout()
                    } label: {
                        Text("Log Out")
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
