//
//  ForgotPasswordView.swift
//  ecommerce-snow-penguins
//
//  Created by Derek Kim on 2024-04-25.
//

import SwiftUI

struct ForgotPasswordView: View {

    // MARK: - Properties

    /// A string of email that user enters.
    @State var email: String = ""

    /// Focus state to indicate that the email text field is selected.
    @FocusState private var emailTextFieldFocused: Bool

    /// An environment that dismisses current sheet.
    @Environment(\.dismiss) private var dismiss

    // MARK: - View Conformance

    var body: some View {
        VStack(spacing: Stylesheet.Spacing.spacing32) {
            imageViewCombined
            resetPasswordDescriptionText
            emailTextField
                .padding(.horizontal)
            buttonStackView
            Spacer()
        }
        .padding(.top, Stylesheet.Padding.padding64)
    }

    // MARK: - Computed Properties

    var imageViewCombined: some View {
        VStack {
            imageView(imageName: "cacart_logo", width: 180)
            imageView(imageName: "forgot_password", width: 300)
        }
    }

    /// A descriptive header and description for password retrieval instructions.
    var resetPasswordDescriptionText: some View {
        VStack(alignment: .center, spacing: Stylesheet.Spacing.spacing8) {
            Text("Forgot your password?")
                .font(.title2.bold())
            Text("Enter your e-mail address and we'll send you\na link to reset your password.")
                .font(.callout)
        }
        .multilineTextAlignment(.center)
    }

    /// TextField that the user use to enter their email to request reset password link to be sent.
    var emailTextField: some View {
        TextField("Email", text: $email)
            .frame(height: 50)
            .padding(.horizontal, 10)
            .focused($emailTextFieldFocused)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(emailTextFieldFocused ? .blue : .gray, lineWidth: 2)
            }
    }

    /// Represents the buttons in HStack View.
    var buttonStackView: some View {
        HStack(spacing: Stylesheet.Padding.padding32) {
            resetButton
            cancelButton
        }
    }

    /// A button to request a password reset link to be sent to the email.
    var resetButton: some View {
        Button {} label: {
            Text("Reset")
        }
        .frame(width: 150, height: 50)
        .foregroundStyle(.white)
        .background(.blue)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    /// A button to cancel request and pop back to previous view.
    var cancelButton: some View {
        Button {
            dismiss()
        } label: {
            Text("Cancel")
                .padding()
        }
        .frame(width: 150, height: 50)
        .foregroundStyle(.white)
        .background(.gray)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    /// Logo image we want to show user.
    @ViewBuilder
    func imageView(imageName: String, width: CGFloat) -> some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(width: width)
    }
}

#Preview {
    ForgotPasswordView()
}
