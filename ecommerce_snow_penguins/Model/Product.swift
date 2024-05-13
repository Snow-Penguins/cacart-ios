//
//  Product.swift
//  ecommerce-snow-penguins
//
//  Created by Derek Kim on 2024-04-23.
//

import Foundation

// MARK: - Product

struct Product: Codable, Identifiable {
    let id: Int
    let categoryId: Int
    let name: String
    let description: String?
    let productImage: [String]?
    let createdAt: Date
    let category: Category
    let productItems: [ProductItem]

    enum CodingKeys: String, CodingKey {
        case id
        case categoryId = "category_id"
        case name
        case description
        case productImage = "product_image"
        case createdAt = "created_at"
        case category
        case productItems = "product_items"
    }
}

struct Category: Codable {
    let name: String
}

struct ProductItem: Codable {
    let price: Double
}
