//
//  AuthManager.swift
//  ecommerce-snow-penguins
//
//  Created by Derek Kim on 2024-04-27.
//

import SwiftUI

// TODO: - Fix this with actual auth flow using Supabase
/// A temporary  manager to manage auth flow.
class AuthManager: ObservableObject {

    // MARK: - Properties

    /// A boolean flag to temporarily check if user is logged in or not.
    @Published var isLoggedIn: Bool = false

    // MARK: - Public Functions

    /// A method to log user out by setting boolean flag to `false`.
    func logout() {
        withAnimation {
            isLoggedIn = false
        }
    }
}
