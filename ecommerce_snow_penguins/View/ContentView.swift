//
//  ContentView.swift
//  ecommerce-snow-penguins
//
//  Created by Derek Kim on 2024-04-23.
//

import SwiftUI

struct ContentView: View {
    // MARK: - View Conformance

    var body: some View {
        TabView {
            Group {
                ProductView()
                    .tabItem {
                        Label("Shop", systemImage: "bag")
                    }

                // TODO: - Best Sellers & New Releases comes here?
                Text("Deals Page")
                    .tabItem {
                        Label("Deals", systemImage: "tag")
                    }

                // TODO: - My Orders comes here?
                Text("Order History Page")
                    .tabItem {
                        Label("History", systemImage: "clock")
                    }

                // TODO: - Account Details page comes here?
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }

                // TODO: - Cart Item comes here?
                CartView()
                    .tabItem {
                        Label("Cart", systemImage: "cart")
                    }
            }
            .toolbarBackground(.white, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
        }
    }
}

#Preview {
    ContentView()
}
