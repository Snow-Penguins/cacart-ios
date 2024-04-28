//
//  CartView.swift
//  ecommerce-snow-penguins
//
//  Created by Derek Kim on 2024-04-24.
//

import SwiftUI

struct CartView: View {
    // MARK: - View Conformance

    var body: some View {
        NavigationStack {
            // TODO: - Add logic to determine if user has any item in cart or not to determine which view to show.
            emptyView
        }
    }

    // MARK: - Properties

    /// An empty view that shows when the cart is empty.
    var emptyView: some View {
        VStack(spacing: 10) {
            Image(systemName: "basket")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)

            Text("Your shopping cart is empty")
                .font(.title2.bold())

            Text("Looking for ideas?")
                .font(.headline)

            Button {} label: {
                Text("Go Shopping")
                    .font(.headline)
            }
            .buttonStyle(.bordered)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .navigationTitle("Cart")
    }
}

#Preview {
    CartView()
}
