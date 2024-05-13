//
//  Validator.swift
//  ecommerce-snow-penguins
//
//  Created by Derek Kim on 2024-05-12.
//

import SwiftUI

/// A `Validator` struct used for validating required textfields entry.
struct Validator {

    /// Validate email using a regular expression and return validation status and error message if any.
    /// - Parameter email: An email string we get from the user entry.
    /// - Returns: A tuple of validity of check and a string value of the error message.
    static func validateEmail(email: String) -> (isValid: Bool, errorMessage: String?) {
        if email.isEmpty {
            return (false, "Email cannot be empty!")
        }
        let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let isValid = email.range(of: emailRegex, options: .regularExpression) != nil
        return (isValid, isValid ? nil : "Invalid email format ❌")
    }

    /// Validate password using a regular expression and return validation status and error message if any.
    /// - Parameter password: A password string we get from the user entry.
    /// - Returns: A tuple of validity of check and a string value of the error message.
    static func validatePassword(password: String) -> (isValid: Bool, errorMessage: String?) {
        if password.isEmpty {
            return (false, "Password cannot be empty!")
        }
        let passwordRegex = "^(?=.*[A-Z])(?=.*\\d)(?=.*[^A-Za-z\\d]).{8,15}$"
        let isValid = password.range(of: passwordRegex, options: .regularExpression) != nil
        return (isValid, isValid ? nil : "Password must contain at least one uppercase letter, one digit, one special character, and be between 8 to 15 characters long.")
    }

    /// Check if passwords match and return validation status and error message if any.
    /// - Parameters:
    ///   - password: A password string we get from the user entry.
    ///   - confirmPassword: A confirm password string we get from the user entry.
    /// - Returns: A tuple of validity of check and a string value of the error message.
    static func validateConfirmPassword(password: String, confirmPassword: String) -> (isValid: Bool, errorMessage: String?) {
        if confirmPassword.isEmpty {
            return (false, "Confirm password cannot be empty!")
        }
        let isValid = password == confirmPassword
        return (isValid, isValid ? nil : "Passwords do not match ❌")
    }

    /// A method to return color based on error message visibility.
    /// - Parameters:
    ///   - isFocused: Checks whether the textfield is currently focused or not.
    ///   - errorMessage: Takes in error message to return the correct color.
    /// - Returns: A color to display based on the focus and error message's visibility.
    static func textFieldStrokeColor(isFocused: Bool, errorMessage: String?) -> Color {
        if isFocused {
            return errorMessage != nil ? .red : .blue
        } else {
            return errorMessage != nil ? .red : .gray
        }
    }
}
