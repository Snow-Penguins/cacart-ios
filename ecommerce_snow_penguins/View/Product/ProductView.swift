//
//  ProductView.swift
//  ecommerce-snow-penguins
//
//  Created by Derek Kim on 2024-04-23.
//

import SwiftUI

struct ProductView: View {
    // MARK: - Properties

    /// A string to keep track of search text we want to pass as search query.
    @State private var searchText: String = ""

    /// Spacing of 20 we use to define our spacing between objects
    let spacing: CGFloat = 20

    /// Padding of 16 we want to use to define our padding.
    let padding: CGFloat = 16

    // TODO: - REMOVE once we have live data.
    /// Mock Data to show products.
    let products = [
        Product(id: 0, category: "Women", name: "Winter Sweater", price: 34.00, imageName: "stacked_pile_of_clothes"),
        Product(id: 1, category: "Men", name: "Regular Fit Sando T-Shirt", price: 25.00, imageName: "women_regular_clothes"),
        Product(id: 2, category: "Ladies", name: "Denim Jacket", price: 134.00, imageName: "lady_denim_jacket"),
        Product(id: 3, category: "Kids", name: "Cotton Play Dress", price: 19.99, imageName: "stacked_pile_of_clothes"),
        Product(id: 4, category: "Travel", name: "Weekender Duffel Bag", price: 79.00, imageName: "women_regular_clothes"),
        Product(id: 5, category: "Electronics", name: "Wireless Headphones", price: 99.99, imageName: "lady_denim_jacket"),
        Product(id: 6, category: "Home", name: "Scented Candle Set", price: 24.50, imageName: "stacked_pile_of_clothes"),
        Product(id: 7, category: "Sports", name: "Running Shoes", price: 89.95, imageName: "women_regular_clothes"),
        Product(id: 8, category: "Books", name: "Science Fiction Novel", price: 15.99, imageName: "lady_denim_jacket"),
        Product(id: 9, category: "Beauty", name: "Moisturizer", price: 32.00, imageName: "stacked_pile_of_clothes"),
        Product(id: 10, category: "Kids", name: "Cotton Play Dress", price: 59.99, imageName: "stacked_pile_of_clothes"),
        Product(id: 11, category: "Books", name: "Science Fiction Novel", price: 15.97, imageName: "lady_denim_jacket"),
    ]

    /// Column that holds products we want to show.
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(searchResults.shuffled(), id: \.id) { product in
                        VStack {
                            NavigationLink {
                                ProductDetailView(product: product)
                            } label: {
                                Image(product.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: imageSize, height: imageSize)
                                    .background(Color.gray.opacity(0.2))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }

                            VStack(alignment: .leading) {
                                Text(product.name)
                                    .font(.headline)
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.primary)
                                Text("$\(product.price, specifier: "%.2f")")
                                    .font(.subheadline)
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                        }
                    }
                }
                .padding(.horizontal, padding)
            }
            .navigationTitle("Product")
        }
        .searchable(text: $searchText, prompt: "Search for anything on Cacart!")
    }

    /// Calculates the available width and height for each image.
    private var imageSize: CGFloat {
        let screenWidth = UIScreen.main.bounds.size.width
        let totalPadding = padding * 2
        let totalSpacing = CGFloat(columns.count - 1) * spacing
        let availableWidth = screenWidth - totalPadding - totalSpacing
        return availableWidth / CGFloat(columns.count)
    }

    /// Search results we want to display to the user based on search text query.
    private var searchResults: [Product] {
        if searchText.isEmpty {
            products
        } else {
            products.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

#Preview {
    ProductView()
}
