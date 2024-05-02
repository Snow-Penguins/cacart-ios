//
//  SocialLoginButtonsView.swift
//  ecommerce-snow-penguins
//
//  Created by Derek Kim on 2024-05-01.
//

import AuthenticationServices
import SwiftUI

struct SocialLoginButtonsView: View {
    // MARK: - View Conformance

    var body: some View {
        socialLoginButtons
    }

    // MARK: - Computed Properties

    /// Social login buttons we want to allow user to use for logging in.
    @ViewBuilder
    var socialLoginButtons: some View {
        googleLoginButton
        appleLoginButton
    }

    /// Google social login button we want to show user.
    var googleLoginButton: some View {
        Button {
            print("Signing into Google")
        } label: {
            HStack {
                Image("ic_google")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
                Text("Continue with Google")
                    .foregroundStyle(.black)
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray, lineWidth: 2)
            }
        }
    }

    /// Apple social login button we want to show user.
    var appleLoginButton: some View {
        SignInWithAppleButton(.signIn) { request in
            request.requestedScopes = [.fullName, .email]
        } onCompletion: { result in
            switch result {
            case let .success(result):
                print("Apple Auth successful - \(result)")
            case let .failure(error):
                print("Apple Auth Failed - \(error.localizedDescription)")
            }
        }
        .signInWithAppleButtonStyle(.black)
        .frame(height: 50)
    }
}

#Preview {
    SocialLoginButtonsView()
}
