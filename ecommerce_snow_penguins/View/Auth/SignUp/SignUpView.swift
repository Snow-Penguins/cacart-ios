//
//  SignUpView.swift
//  ecommerce-snow-penguins
//
//  Created by Derek Kim on 2024-05-01.
//

import SwiftUI

struct SignUpView: View {
    // MARK: - Properties

    /// A string of email that user enters.
    @State var email: String = ""

    /// A string of password that user enters.
    @State var password: String = ""

    /// A string of confirm password that user enters.
    @State var confirmPassword: String = ""

    /// A boolean flag to determine visibility of the password.
    @State var isPasswordVisible: Bool = false

    /// Focus state to indicate that the email text field is selected.
    @FocusState private var emailTextFieldFocused: Bool

    /// Focus state to indicate that the password text field is selected.
    @FocusState private var passwordTextFieldFocused: Bool

    /// Focus state to indicate that the password text field is selected.
    @FocusState private var confirmPasswordTextFieldFocused: Bool

    // State for determining the sheet type. Defaults to nil.
    @State private var termsAndPolicySheetType: TermsAndPolicySheetType? = nil

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
                .frame(height: 50)
                .padding(.horizontal, 10)
                .focused($emailTextFieldFocused)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(emailTextFieldFocused ? .blue : .gray, lineWidth: 2)
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
            .frame(height: 50)
            .padding(.horizontal, 10)
            .focused($passwordTextFieldFocused)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(passwordTextFieldFocused ? .blue : .gray, lineWidth: 2)
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
                if isPasswordVisible {
                    TextField("Password", text: $confirmPassword)
                } else {
                    SecureField("Password", text: $confirmPassword)
                }

                Button {
                    isPasswordVisible.toggle()
                } label: {
                    Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                        .foregroundStyle(confirmPasswordTextFieldFocused ? .blue : .gray)
                }
            }
            .frame(height: 50)
            .padding(.horizontal, 10)
            .focused($confirmPasswordTextFieldFocused)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(confirmPasswordTextFieldFocused ? .blue : .gray, lineWidth: 2)
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
            print("hehe")
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

#Preview {
    SignUpView()
}
