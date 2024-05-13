//
//  AuthManager.swift
//  ecommerce-snow-penguins
//
//  Created by Derek Kim on 2024-04-27.
//

import SwiftUI
import Supabase

class AuthManager: ObservableObject {

    // MARK: - Private Initializer

    init() {
        Task {
            await refreshSession()
        }
    }

    // MARK: - Properties

    @Published var isLoggedIn: Bool = false

    /*
     Anonymous key is safe to keep it on the client side.
     Secret key should be kept secret as it gives access to everything.
     Link: https://www.youtube.com/watch?v=enVDRqzmudo
     */
    let client = SupabaseClient(
        supabaseURL: URL(string: "https://rpigtsfxbtniriathatk.supabase.co")!,
        supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJwaWd0c2Z4YnRuaXJpYXRoYXRrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTA3MzYyMjQsImV4cCI6MjAyNjMxMjIyNH0.uNHeicQFBFY3oBnE4GUZhsfBtaPrRQ_8WiTfKQ7_7vM"
    )

    // MARK: - Public Methods

    @MainActor
    func refreshSession() async {
        do {
            let session = try await client.auth.session
            isLoggedIn = !session.user.id.uuidString.isEmpty
        } catch {
            isLoggedIn = false
        }
    }

    func getCurrentSession() async -> AppUser? {
      guard let session = try? await client.auth.session else {
        return nil
      }
      print("session : \(session.user)")
      let appUser = AppUser(uid: session.user.id.uuidString, email: session.user.email)
      print(appUser)
      return appUser
    }

    @MainActor
    func signInAnonymously() async {
        do {
            let session = try await client.auth.signInAnonymously()
            print("User ID: \(session.user.id.uuidString)")
            await refreshSession()
        } catch {
            print("Error during anonymous sign-in: \(error)")
        }
    }

    func getLoggedInUser() async -> AppUser? {
        return await getCurrentSession()
      }

    func signOut() async {
        do {
            try await client.auth.signOut()
            await refreshSession()
            let session = try await client.auth.session
            print("Successfully Signed Out = \(session)")
        } catch {
//            print("Error signing out - \(error.localizedDescription)")
        }
    }
}
