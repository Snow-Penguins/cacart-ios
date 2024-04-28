//
//  Product.swift
//  ecommerce-snow-penguins
//
//  Created by Derek Kim on 2024-04-23.
//

import Foundation

// MARK: - Product

struct Product: Codable {
    let id: Int
    let category, name: String
    let price: Double
    let imageName: String
}
