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

    /// A state variable to indicate which tab is active. Defaults to `.home`.
    @State private var activeTab: Tab = .home

    /// A property to determine which color scheme user is on.
    @Environment(\.colorScheme) private var scheme

    /// A Namespace property to control the active tab bar's animation.
    @Namespace private var animation

    /// A state that determines if user is on a specific view or field.
    @FocusState private var isSearching: Bool

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
    let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: Stylesheet.Spacing.spacing16), count: 3)

    // MARK: - View Conformance

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: Stylesheet.Spacing.spacing20) {
                ForEach(searchResults.shuffled(), id: \.id) { product in
                    VStack(alignment: .leading) {
                        NavigationLink {
                            ProductDetailView(product: product)
                        } label: {
                            productCell(product: product)
                        }
                    }
                }
            }
            .safeAreaPadding(Stylesheet.Padding.padding16)
            .safeAreaInset(edge: .top, spacing: Stylesheet.Spacing.spacing0) {
                expandableNavigationBar()
            }
            .animation(.snappy(duration: 0.3, extraBounce: 0), value: isSearching)
        }
        .scrollTargetBehavior(CustomScrollTargetBehaviour())
        .background(.gray.opacity(0.15))
        .contentMargins(.top, 190, for: .scrollIndicators)
    }

    // MARK: - Computed Properties

    /// A scrollable filter view with options in capsule style view.
    var filterView: some View {
        ScrollView(.horizontal) {
            HStack(spacing: Stylesheet.Spacing.spacing12) {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Button {
                        withAnimation(.snappy) {
                            activeTab = tab
                        }
                    } label: {
                        Text(tab.rawValue)
                            .font(.callout)
                            .foregroundStyle(activeTab == tab ? (scheme == .dark ? .black : .white) : Color.primary)
                            .padding(.vertical, Stylesheet.Padding.padding8)
                            .padding(.horizontal, Stylesheet.Padding.padding16)
                            .background {
                                if activeTab == tab {
                                    Capsule()
                                        .fill(Color.primary)
                                        .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                                } else {
                                    Capsule()
                                        .fill(.background)
                                }
                            }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .scrollIndicators(.hidden)
        .frame(height: 50)
    }

    /// Calculates the available width and height for each image.
    private var imageSize: CGFloat {
        let screenWidth = UIScreen.main.bounds.size.width
        let totalPadding = Stylesheet.Padding.padding16 * 2
        let totalSpacing = CGFloat(columns.count - 1) * Stylesheet.Spacing.spacing20
        let availableWidth = screenWidth - totalPadding - totalSpacing
        return (availableWidth / CGFloat(columns.count)) + 10
    }

    /// Search results we want to display to the user based on search text query.
    private var searchResults: [Product] {
        if searchText.isEmpty {
            products
        } else {
            products.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    // MARK: - Public Methods

    /// A product cell we want to show user to present product information.
    /// - Parameter product: Takes `Product` object to pass the product data.
    /// - Returns: A view of `ProductCell` we want to show user.
    @ViewBuilder
    func productCell(product: Product) -> some View {
        VStack(alignment: .leading, spacing: Stylesheet.Spacing.spacing0) {
            Image(product.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: imageSize, height: imageSize)
                .background(Color.gray.opacity(0.2))
                .clipShape(.rect(topLeadingRadius: 10, topTrailingRadius: 10))

            VStack(alignment: .leading, spacing: Stylesheet.Spacing.spacing8) {
                Text(product.name)
                    .font(.headline)
                    .foregroundStyle(.black)
                    .padding([.leading, .top], Stylesheet.Padding.padding8)

                Text("$\(product.price, specifier: "%.2f")")
                    .font(.subheadline.bold())
                    .foregroundStyle(.gray)
                    .padding(.leading, Stylesheet.Padding.padding8)

                Spacer()
            }
            .frame(width: imageSize, alignment: .leading)
            .background(scheme == .dark ? .white : .white)
        }
        .multilineTextAlignment(.leading)
        .clipShape(.rect(bottomLeadingRadius: 10, bottomTrailingRadius: 10))
        .padding(.leading, Stylesheet.Padding.padding10)
    }

    /// An expandable navigation bar that represents customized navigation bar.
    /// - Parameter title: A string that represents the navigation title.
    /// - Returns: A view that contains navigation title, searchable field, and custom tab selection view.
    @ViewBuilder
    func expandableNavigationBar(_ title: String = "Product") -> some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .scrollView(axis: .vertical)).minY
            let scrollviewHeight = proxy.bounds(of: .scrollView(axis: .vertical))?.height ?? 0
            let scaleProgress = minY > 0 ? 1 + (max(min(minY / scrollviewHeight, 1), 0) * 0.5) : 1
            let progress = isSearching ? 1 : max(min(-minY / 70, 1), 0)

            VStack(spacing: Stylesheet.Spacing.spacing10) {
                Text(title)
                    .font(.largeTitle.bold())
                    .scaleEffect(scaleProgress, anchor: .topLeading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, Stylesheet.Padding.padding10)

                HStack(spacing: Stylesheet.Spacing.spacing12) {
                    Image(systemName: "magnifyingglass")
                        .font(.title)

                    TextField("Search for anything on Cacart!", text: $searchText)
                        .focused($isSearching)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)

                    if isSearching {
                        Button {
                            isSearching = false
                            searchText = ""
                        } label: {
                            Image(systemName: "xmark")
                                .font(.title)
                        }
                        .transition(.asymmetric(insertion: .push(from: .bottom), removal: .push(from: .top)))
                    }
                }
                .foregroundStyle(.primary)
                .padding(.vertical, Stylesheet.Padding.padding10)
                .padding(.horizontal, 15 - (progress * 15))
                .frame(height: 45)
                .clipShape(.capsule)
                .background {
                    RoundedRectangle(cornerRadius: 25 - (progress * 25))
                        .fill(.background)
                        .shadow(color: .gray.opacity(0.25), radius: 5, x: 0, y: 5)
                        .padding(.top, -progress * 190)
                        .padding(.bottom, -progress * 65)
                        .padding(.horizontal, -progress * 15)
                }
                filterView
            }
            .padding(.top, Stylesheet.Padding.padding24)
            .safeAreaPadding(.horizontal, Stylesheet.Padding.padding16)
            .offset(y: minY < 0 || isSearching ? -minY : 0)
            .offset(y: -progress * 65)
        }
        .frame(height: 190)
        .padding(.bottom, Stylesheet.Padding.padding10)
        .padding(.bottom, isSearching ? -Stylesheet.Padding.padding64 : Stylesheet.Padding.padding0)
    }
}

#Preview {
    ProductView()
}
