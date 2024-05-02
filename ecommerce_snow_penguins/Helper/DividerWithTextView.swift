//
//  DividerWithTextView.swift
//  ecommerce-snow-penguins
//
//  Created by Derek Kim on 2024-05-01.
//

import SwiftUI

struct DividerWithTextView: View {
    // MARK: - Enums

    enum DividerText: String {
        case connectWith
        case or

        var title: String {
            switch self {
            case .connectWith:
                "Connect With"
            case .or:
                "OR"
            }
        }
    }

    // MARK: - Properties

    let dividerTextType: DividerText

    // MARK: - View Conformance

    var body: some View {
        dividerText
    }

    // MARK: - Computed Properties

    /// A view that has two dividers with text in the middle.
    var dividerText: some View {
        HStack {
            horizontalDivider
            Text(dividerTextType.title)
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
}

#Preview {
    DividerWithTextView(dividerTextType: .connectWith)
}
