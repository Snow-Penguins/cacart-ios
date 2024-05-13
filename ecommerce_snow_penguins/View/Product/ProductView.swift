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
        Product(
            id: 0,
            categoryId: 1,
            name: "Winter Sweater",
            description: nil,
            productImage: ["winter_sweater", "women_regular_clothes", "lady_denim_jacket"],
            createdAt: Date(),
            category: Category(name: "Women"),
            productItems: [ProductItem(price: 34.00)]
        ),
        Product(
            id: 1,
            categoryId: 2,
            name: "Regular Fit Sando T-Shirt",
            description: nil,
            productImage: ["regular-fit", "women_regular_clothes"],
            createdAt: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, // 2 days ago
            category: Category(name: "Men"),
            productItems: [ProductItem(price: 25.00)]
        ),
        Product(
            id: 2,
            categoryId: 3,
            name: "Denim Jacket",
            description: nil,
            productImage: ["denim_jacket", "lady_denim_jacket"],
            createdAt: Date(),
            category: Category(name: "Ladies"),
            productItems: [ProductItem(price: 134.00)]
        ),
        Product(
            id: 3,
            categoryId: 4,
            name: "Cotton Play Dress",
            description: nil,
            productImage: ["cotton_play_dress", "stacked_pile_of_clothes"],
            createdAt: Date(),
            category: Category(name: "Kids"),
            productItems: [ProductItem(price: 19.99)]
        ),
        Product(
            id: 4,
            categoryId: 5,
            name: "Weekender Duffel Bag",
            description: nil,
            productImage: ["weekender_duffel_bag", "women_regular_clothes"],
            createdAt: Date(),
            category: Category(name: "Travel"),
            productItems: [ProductItem(price: 79.00)]
        ),
        Product(
            id: 5,
            categoryId: 1,
            name: "Cozy Beanie",
            description: nil,
            productImage: ["cozy_beanie", "stacked_pile_of_clothes", "women_regular_clothes"],
            createdAt: Calendar.current.date(byAdding: .day, value: -10, to: Date())!, // 10 days ago
            category: Category(name: "Women"),
            productItems: [ProductItem(price: 15.99)]
        ),
        Product(
            id: 6,
            categoryId: 2,
            name: "Running Shorts",
            description: nil,
            productImage: ["running_shorts", "women_regular_clothes"],
            createdAt: Date(), // Today
            category: Category(name: "Men"),
            productItems: [ProductItem(price: 42.50)]
        ),
        Product(
            id: 7,
            categoryId: 3,
            name: "Leather Laptop Bag",
            description: nil,
            productImage: ["leather_laptop_bag", "women_regular_clothes"],
            createdAt: Calendar.current.date(byAdding: .month, value: -2, to: Date())!, // 2 months ago
            category: Category(name: "Accessories"),
            productItems: [ProductItem(price: 199.00)]
        ),
        Product(
            id: 8,
            categoryId: 4,
            name: "Plush Stuffed Animal",
            description: nil,
            productImage: ["plush_stuffed_animal", "stacked_pile_of_clothes"],
            createdAt: Calendar.current.date(byAdding: .hour, value: -5, to: Date())!, // 5 hours ago
            category: Category(name: "Kids"),
            productItems: [ProductItem(price: 12.99)]
        ),
        Product(
            id: 9,
            categoryId: 5,
            name: "Hiking Backpack",
            description: nil,
            productImage: ["hiking_backpack", "stacked_pile_of_clothes"],
            createdAt: Calendar.current.date(byAdding: .weekOfYear, value: -1, to: Date())!, // Last week
            category: Category(name: "Travel"),
            productItems: [ProductItem(price: 99.99)]
        ),
    ]

    /// Column that holds products we want to show.
    let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: Stylesheet.Spacing.spacing16), count: 3)

    // MARK: - View Conformance

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: Stylesheet.Spacing.spacing20) {
                    ForEach(searchResults) { product in
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
            filteredProductsByDate
        } else {
            products.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    /// Filtered by `createdAt` results we want to display to the user.
    private var filteredProductsByDate: [Product] {
        switch activeTab {
        case .home, .bestSellers:
            products
        case .newReleases:
            products.sorted(by: { $0.createdAt > $1.createdAt })
        }
    }

    // MARK: - Public Methods

    /// A product cell we want to show user to present product information.
    /// - Parameter product: Takes `Product` object to pass the product data.
    /// - Returns: A view of `ProductCell` we want to show user.
    @ViewBuilder
    func productCell(product: Product) -> some View {
        VStack(alignment: .leading, spacing: Stylesheet.Spacing.spacing0) {
            if let image = product.productImage?.first {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageSize, height: imageSize)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(.rect(topLeadingRadius: 10, topTrailingRadius: 10))
            }

            VStack(alignment: .leading, spacing: Stylesheet.Spacing.spacing8) {
                Text(product.name)
                    .font(.headline)
                    .foregroundStyle(.black)
                    .padding([.leading, .top], Stylesheet.Padding.padding8)

                if let price = product.productItems.first?.price {
                    Text("$\(price, specifier: "%.2f")")
                        .font(.subheadline.bold())
                        .foregroundStyle(.gray)
                        .padding(.leading, Stylesheet.Padding.padding8)
                }

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
