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

    /// Active index to keep track of the current product variant shown.
    @State private var activeIndex: Int = 0

    // MARK: - View Conformance

    var body: some View {
        VStack(alignment: .leading, spacing: Stylesheet.Spacing.spacing12) {
            if !product.productItems.isEmpty {
                GroupBox {
                    TabView(selection: $activeIndex) {
                        ForEach(product.productImage?.indices ?? 0 ..< 0, id: \.self) { index in
                            Image(product.productImage?[index] ?? "")
                                .resizable()
                                .scaledToFill()
                                .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .padding(.bottom, 10)
                    .frame(height: 300)
                }
            }

            Text(product.name)
                .font(.title.bold())

            if !product.productItems.isEmpty, activeIndex < product.productItems.count {
                Text("$\(product.productItems[activeIndex].price, specifier: "%.2f")")
                    .font(.headline)
            } else if !product.productItems.isEmpty {
                Text("$\(product.productItems.first?.price ?? 0, specifier: "%.2f")")
                    .font(.headline)
            }

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
    let product = Product(
        id: 1,
        categoryId: 2,
        name: "Regular Fit Sando T-Shirt",
        description: nil,
        productImage: ["women_regular_clothes"],
        createdAt: Date(),
        category: Category(name: "Men"),
        productItems: [ProductItem(price: 25.00)]
    )
    return ProductDetailView(product: product)
}
