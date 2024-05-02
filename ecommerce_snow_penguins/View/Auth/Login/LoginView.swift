//
//  LoginView.swift
//  ecommerce-snow-penguins
//
//  Created by Derek Kim on 2024-04-24.
//

import SwiftUI

struct LoginView: View {
    // MARK: - Enum

    enum SheetType: String, Identifiable {
        case forgotPassword = "Forgot Password"
        case signUp = "Sign Up"

        var id: String { rawValue }
    }

    // MARK: - Properties

    /// A temporary  manager to manage auth flow.
    @EnvironmentObject var authManager: AuthManager

    /// A string of email that user enters.
    @State var email: String = ""

    /// A string of password that user enters.
    @State var password: String = ""

    /// A boolean flag to determine visibility of the password.
    @State var isPasswordVisible: Bool = false

    // State for determining the sheet type. Defaults to nil.
    @State private var sheetType: SheetType? = nil

    /// Focus state to indicate that the email text field is selected.
    @FocusState private var emailTextFieldFocused: Bool

    /// Focus state to indicate that the password text field is selected.
    @FocusState private var passwordTextFieldFocused: Bool

    // MARK: - View Conformance

    var body: some View {
        NavigationStack {
            VStack(spacing: Stylesheet.Spacing.spacing24) {
                logoImageView
                loginTextField
                passwordTextField
                loginButton
                DividerWithTextView(dividerTextType: .connectWith)
                SocialLoginButtonsView()
                registrationAndPasswordRetrieval
            }
            .padding(.horizontal)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        authManager.isLoggedIn = true
                    } label: {
                        Text("Continue as guest")
                            .foregroundStyle(.black)
                            .font(.callout)
                    }
                }
            }
            .sheet(item: $sheetType) { type in
                if type == .forgotPassword {
                    ForgotPasswordView()
                } else {
                    SignUpView()
                }
            }
        }
    }

    // MARK: - Computed Properties

    /// Logo image we want to show user.
    var logoImageView: some View {
        Image("cacart_logo")
            .resizable()
            .scaledToFit()
            .frame(width: 200)
    }

    /// TextField that the user use to enter their email to login.
    var loginTextField: some View {
        TextField("Email", text: $email)
            .frame(height: 50)
            .padding(.horizontal, 10)
            .focused($emailTextFieldFocused)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(emailTextFieldFocused ? .blue : .gray, lineWidth: 2)
            }
    }

    /// TextField that the user use to enter their password to login.
    var passwordTextField: some View {
        HStack {
            if isPasswordVisible {
                TextField("Password", text: $password)
            } else {
                SecureField("Password", text: $password)
            }

            Button {
                isPasswordVisible.toggle()
            } label: {
                Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                    .foregroundStyle(passwordTextFieldFocused ? .blue : .gray)
            }
        }
        .frame(height: 50)
        .padding(.horizontal, 10)
        .focused($passwordTextFieldFocused)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(passwordTextFieldFocused ? .blue : .gray, lineWidth: 2)
        }
    }

    /// Sign in button to allow user to try login.
    var loginButton: some View {
        Button {
            print("hehe")
        } label: {
            Text("Sign In")
                .font(.title3)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color(hex: 0x3758F9))
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    /// A view that has two dividers with text in the middle.
    var dividerText: some View {
        HStack {
            horizontalDivider
            Text("Connect With")
                .padding(.horizontal)
                .fixedSize(horizontal: true, vertical: false)
            horizontalDivider
        }
        .foregroundStyle(.gray)
    }

    /// A horizontal divider we want to show user.
    var horizontalDivider: some View {
        Rectangle()
            .frame(height: 1)
    }

    /// A VStack view that consists two different buttons.
    var registrationAndPasswordRetrieval: some View {
        VStack(spacing: 8) {
            forgotPasswordButton
            registrationTextButton
        }
    }

    /// Forgot password button we want to show user.
    var forgotPasswordButton: some View {
        Button {
            sheetType = .forgotPassword
        } label: {
            Text("Forgot Password?")
                .foregroundStyle(.black)
        }
    }

    /// Registration button we want to show user.
    var registrationTextButton: some View {
        HStack {
            Text("Not a member yet?")
                .foregroundStyle(.secondary)
            Button {
                sheetType = .signUp
            } label: {
                Text("Sign Up")
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthManager())
}
