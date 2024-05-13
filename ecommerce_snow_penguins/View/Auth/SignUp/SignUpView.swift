//
//  SignUpView.swift
//  ecommerce-snow-penguins
//
//  Created by Derek Kim on 2024-05-01.
//

import SwiftUI

struct SignUpView: View {
    // MARK: - Properties

    /// A view model used for authentication.
    @ObservedObject var authManager: AuthManager

    /// A string of email that user enters.
    @State var email: String = ""

    /// A string of password that user enters.
    @State var password: String = ""

    /// A string of confirm password that user enters.
    @State var confirmPassword: String = ""

    /// A boolean flag to determine visibility of the password. Defaults to `false`.
    @State var isPasswordVisible: Bool = false

    /// A boolean flag to determine visibility of the confirm password. Defaults to `false`.
    @State var isConfirmPasswordVisible: Bool = false

    /// An error message to show when email validation has failed.  Defaults to `nil`.
    @State private var emailErrorMessage: String? = nil

    /// An error message to show when password validation has failed.  Defaults to `nil`.
    @State private var passwordErrorMessage: String? = nil

    /// An error message to show when confirm password validation has failed.  Defaults to `nil`.
    @State private var confirmPasswordErrorMessage: String? = nil

    /// A state variable to check if email is valid or not. Defaults to `false`.
    @State private var isEmailValid = false

    /// A state variable to check if password is valid or not. Defaults to `false`.
    @State private var isPasswordValid = false

    /// A state variable to check if confirm password is valid or not. Defaults to `false`.
    @State private var isConfirmPasswordValid = false

    // State for determining the sheet type. Defaults to `nil`.
    @State private var termsAndPolicySheetType: TermsAndPolicySheetType? = nil

    /// Focus state to indicate that the email text field is selected.
    @FocusState private var emailTextFieldFocused: Bool

    /// Focus state to indicate that the password text field is selected.
    @FocusState private var passwordTextFieldFocused: Bool

    /// Focus state to indicate that the password text field is selected.
    @FocusState private var confirmPasswordTextFieldFocused: Bool

    // MARK: - View Conformance

    var body: some View {
        VStack(spacing: Stylesheet.Spacing.spacing24) {
            logoImageView
            authTextFieldStack
            termsAndPrivacyText
            registerButton
            DividerWithTextView(dividerTextType: .or)
            SocialLoginButtonsView()
        }
        .padding(.horizontal)
        .sheet(item: $termsAndPolicySheetType) { termsAndPolicySheetType in
            TermsAndPrivacyView(termsAndPolicySheetType: termsAndPolicySheetType)
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

    /// A stack view that holds all the required textfield for registration.
    var authTextFieldStack: some View {
        VStack(spacing: Stylesheet.Spacing.spacing16) {
            loginTextField
            passwordTextField
            confirmPasswordTextField
        }
    }

    /// TextField that the user use to enter their email.
    var loginTextField: some View {
        VStack(alignment: .leading) {
            Text("Email Address") +
            Text(" *")
                .foregroundColor(.red)
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
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
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

    /// TextField that the user use to enter their password.
    var passwordTextField: some View {
        VStack(alignment: .leading) {
            Text("Password") +
            Text(" *")
                .foregroundColor(.red)
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
            .onChange(of: password) { _, newValue in
                if passwordErrorMessage != nil {
                    performPasswordValidation(password: newValue)
                }
            }
            .onChange(of: password) { _, newValue in
                if newValue.count == confirmPassword.count {
                    performConfirmPasswordValidation()
                }
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

    /// TextField that the user use to enter their password to confirm.
    var confirmPasswordTextField: some View {
        VStack(alignment: .leading) {
            Text("Confirm Password") +
            Text(" *")
                .foregroundColor(.red)
            HStack {
                if isConfirmPasswordVisible {
                    TextField("Password", text: $confirmPassword)
                } else {
                    SecureField("Password", text: $confirmPassword)
                }

                Button {
                    isConfirmPasswordVisible.toggle()
                } label: {
                    Image(systemName: isConfirmPasswordVisible ? "eye" : "eye.slash")
                        .foregroundStyle(confirmPasswordTextFieldFocused ? .blue : .gray)
                }
            }
            .onChange(of: confirmPasswordTextFieldFocused) {
                if !confirmPasswordTextFieldFocused {
                    performConfirmPasswordValidation()
                }
            }
            .onChange(of: confirmPassword) { _, newValue in
                if newValue.count == password.count {
                    performConfirmPasswordValidation()
                }
            }
            .frame(height: 50)
            .padding(.horizontal, 10)
            .focused($confirmPasswordTextFieldFocused)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Validator.textFieldStrokeColor(isFocused: confirmPasswordTextFieldFocused, errorMessage: confirmPasswordErrorMessage))
            }
            if let errorMessage = confirmPasswordErrorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }

    // Custom view for displaying terms and privacy links
    var termsAndPrivacyText: some View {
        let baseText = "By clicking Register or Continue with Google, you agree to CaCart's "
        let termsText = "Terms of Use"
        let privacyText = "Privacy Policy"
        let fullText = baseText + termsText + " and " + privacyText + "."

        var attributedString = AttributedString(fullText)

        if let range = attributedString.range(of: termsText) {
            attributedString[range].foregroundColor = .blue
            attributedString[range].underlineStyle = .single
            attributedString[range].link = URL(string: "cacart://terms")
        }

        if let range = attributedString.range(of: privacyText) {
            attributedString[range].foregroundColor = .blue
            attributedString[range].underlineStyle = .single
            attributedString[range].link = URL(string: "cacart://privacy")
        }

        return VStack {
            Text(attributedString)
                .multilineTextAlignment(.leading)
                .font(.footnote)
                .onOpenURL { url in
                    switch url.host {
                    case "terms":
                        termsAndPolicySheetType = .termsOfUse
                    case "privacy":
                        termsAndPolicySheetType = .privacyPolicy
                    default:
                        break
                    }
                }
        }
    }

    /// Register button to allow user to create an account.
    var registerButton: some View {
        Button {
            performEmailValidation(email: email)
            performPasswordValidation(password: password)
            performConfirmPasswordValidation()

            if isEmailValid && isPasswordValid && isConfirmPasswordValid {
                print("All validations passed, proceed with registration")
                // TODO: - Implement Supabase registration
            }
        } label: {
            Text("Register")
                .font(.title3)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color(hex: 0x3758F9))
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

// MARK: - Private Methods

private extension SignUpView {

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
        let validationResult = Validator.validatePassword(password: password)
        passwordErrorMessage = validationResult.errorMessage
        isPasswordValid = validationResult.isValid
    }

    /// Performs email validation check for email textfield.
    func performConfirmPasswordValidation() {
        let validationResult = Validator.validateConfirmPassword(password: password, confirmPassword: confirmPassword)
        confirmPasswordErrorMessage = validationResult.errorMessage
        isConfirmPasswordValid = validationResult.isValid
    }
}

