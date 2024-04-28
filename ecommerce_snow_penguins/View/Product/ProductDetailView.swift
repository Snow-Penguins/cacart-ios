//
//  ProductDetailView.swift
//  ecommerce-snow-penguins
//
//  Created by Derek Kim on 2024-04-23.
//

import SwiftUI

struct ProductDetailView: View {
    // MARK: - Properties

    /// Product we get from its parent view.
    let product: Product

    // MARK: - View Conformance

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(product.imageName)
                .resizable()
                .scaledToFit()
            Text(product.name)
                .font(.title.bold())
            Text("$\(product.price, specifier: "%.2f")")
                .font(.headline)
            Text("""
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut magna, scelerisque vitae augue et, cursus placerat lorem.
            In nisi lacus, eleifend tincidunt quam et, consequat semper.
            """)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    let product = Product(id: 0, category: "Women", name: "Winter Sweater", price: 34.00, imageName: "stacked_pile_of_clothes")
    return ProductDetailView(product: product)
}
