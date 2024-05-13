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
        case forgotPassword
        case signUp

        /// Id of each cases of the sheet type.
        var id: String { rawValue }
    }

    // MARK: - Properties

    /// A temporary  manager to manage auth flow.
    @EnvironmentObject var authManager: AuthManager

    /// A string of email that user enters.
    @State var email: String = ""

    /// A string of password that user enters.
    @State var password: String = ""

    /// An error message to show when email validation has failed.  Defaults to `nil`.
    @State private var emailErrorMessage: String? = nil

    /// An error message to show when password validation has failed.  Defaults to `nil`.
    @State private var passwordErrorMessage: String? = nil

    /// A state variable to check if email is valid or not. Defaults to `false`.
    @State private var isEmailValid = false

    /// A state variable to check if password is valid or not. Defaults to `false`.
    @State private var isPasswordValid = false

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
                        Task {
                            await authManager.signInAnonymously()
                        }
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
                    SignUpView(authManager: authManager)
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
        VStack(alignment: .leading) {
            TextField("Email", text: $email)
                .onChange(of: emailTextFieldFocused) {
                    if !emailTextFieldFocused {
                        performEmailValidation(email: email)
                    }
                }
                .onChange(of: email) { _, newValue in
                    if emailErrorMessage != nil {
                        performEmailValidation(email: newValue)
                    }
                }
                .frame(height: 50)
                .padding(.horizontal, 10)
                .focused($emailTextFieldFocused)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Validator.textFieldStrokeColor(isFocused: emailTextFieldFocused, errorMessage: emailErrorMessage))
                }
            if let errorMessage = emailErrorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }

    /// TextField that the user use to enter their password to login.
    var passwordTextField: some View {
        VStack(alignment: .leading) {
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
            .onChange(of: passwordTextFieldFocused) {
                if !passwordTextFieldFocused {
                    performPasswordValidation(password: password)
                }
            }
            .onChange(of: password) {
                performPasswordValidation(password: password)
            }
            .frame(height: 50)
            .padding(.horizontal, 10)
            .focused($passwordTextFieldFocused)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Validator.textFieldStrokeColor(isFocused: passwordTextFieldFocused, errorMessage: passwordErrorMessage))
            }
            if let errorMessage = passwordErrorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }

    /// Sign in button to allow user to try login.
    var loginButton: some View {
        Button {
            performEmailValidation(email: email)
            performPasswordValidation(password: password)

            if isEmailValid && isPasswordValid {
                print("Logging in...")

                // TODO: - Perform login via Supabase
            }
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

// MARK: - Private Methods

private extension LoginView {

    /// Performs email validation check for email textfield.
    /// - Parameter email: String value we take from user entry for email.
    func performEmailValidation(email: String) {
        let validationResult = Validator.validateEmail(email: email)
        emailErrorMessage = validationResult.errorMessage
        isEmailValid = validationResult.isValid
    }

    /// Performs password validation check for password textfield.
    /// - Parameter password: String value we take from user entry for password.
    func performPasswordValidation(password: String) {
        if password.isEmpty {
            passwordErrorMessage = "Password cannot be empty!"
            isPasswordValid = false
        } else {
            passwordErrorMessage = nil
            isPasswordValid = true
        }
    }
}
