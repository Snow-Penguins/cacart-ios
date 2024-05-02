//
//  TermsAndPrivacyView.swift
//  ecommerce-snow-penguins
//
//  Created by Derek Kim on 2024-05-01.
//

import SwiftUI

struct TermsAndPrivacyView: View {
    // MARK: - Properties

    let termsAndPolicySheetType: TermsAndPolicySheetType

    // MARK: - View Conformance

    var body: some View {
        VStack(alignment: .leading, spacing: Stylesheet.Spacing.spacing16) {
            Text(termsAndPolicySheetType.title)
                .padding()

            Text(termsAndPolicySheetType.description)
                .font(.callout)
                .padding()
                .multilineTextAlignment(.leading)
        }
        .background(.pink)
    }
}

#Preview {
    TermsAndPrivacyView(termsAndPolicySheetType: .termsOfUse)
}
