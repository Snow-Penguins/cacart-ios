//
//  TermsAndPolicySheetType.swift
//  ecommerce-snow-penguins
//
//  Created by Derek Kim on 2024-05-01.
//

import Foundation

enum TermsAndPolicySheetType: String, Identifiable {
    case termsOfUse
    case privacyPolicy

    /// Id of each case to conform with Identifable.
    var id: String { rawValue }

    /// Title text of each case.
    var title: String {
        switch self {
        case .termsOfUse:
            "Terms of Use"
        case .privacyPolicy:
            "Privacy Policy"
        }
    }

    // FIXME: - Replace Lorem Ipsum text with real terms of use and privacy policy text.
    /// Description of each case.
    var description: String {
        switch self {
        case .termsOfUse:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt " +
                "ut labore et dolore magna aliqua. Dictumst quisque sagittis purus sit amet volutpat consequat. " +
                "Nisl suscipit adipiscing bibendum est. Lectus nulla at volutpat diam. Amet est placerat in egestas " +
                "erat. Aenean et tortor at risus viverra adipiscing at. In pellentesque massa placerat duis ultricies " +
                "lacus. Magna sit amet purus gravida. Non curabitur gravida arcu ac tortor dignissim convallis aenean. " +
                "Tincidunt ornare massa eget egestas purus viverra accumsan in." +
                "\n\n" +
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt " +
                "ut labore et dolore magna aliqua. Dictumst quisque sagittis purus sit amet volutpat consequat. " +
                "Nisl suscipit adipiscing bibendum est. Lectus nulla at volutpat diam. Amet est placerat in egestas " +
                "erat. Aenean et tortor at risus viverra adipiscing at. In pellentesque massa placerat duis ultricies " +
                "lacus. Magna sit amet purus gravida. Non curabitur gravida arcu ac tortor dignissim convallis aenean. " +
                "Tincidunt ornare massa eget egestas purus viverra accumsan in."
        case .privacyPolicy:
            "Pellentesque massa placerat duis ultricies lacus sed turpis. Diam maecenas ultricies mi eget. " +
                "Ipsum nunc aliquet bibendum enim facilisis gravida. Tellus at urna condimentum mattis pellentesque " +
                "id nibh tortor id. Odio pellentesque diam volutpat commodo sed. Aliquam sem fringilla ut morbi tincidunt " +
                "augue. Urna neque viverra justo nec ultrices dui sapien eget. Integer enim neque volutpat ac tincidunt " +
                "vitae semper quis lectus. A erat nam at lectus urna duis convallis convallis. Vitae suscipit tellus mauris " +
                "a diam maecenas. Fusce ut placerat orci nulla. Etiam non quam lacus suspendisse faucibus interdum posuere lorem." +
                "\n\n" +
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt " +
                "ut labore et dolore magna aliqua. Dictumst quisque sagittis purus sit amet volutpat consequat. " +
                "Nisl suscipit adipiscing bibendum est. Lectus nulla at volutpat diam. Amet est placerat in egestas " +
                "erat. Aenean et tortor at risus viverra adipiscing at. In pellentesque massa placerat duis ultricies " +
                "lacus. Magna sit amet purus gravida. Non curabitur gravida arcu ac tortor dignissim convallis aenean. " +
                "Tincidunt ornare massa eget egestas purus viverra accumsan in."
        }
    }
}
