//
//  CustomScrollTargetBehaviour.swift
//  ecommerce-snow-penguins
//
//  Created by Derek Kim on 2024-04-27.
//

import SwiftUI

/// Custom scroll target behaviour defined to force user to scroll through or back in between.
struct CustomScrollTargetBehaviour: ScrollTargetBehavior {
    func updateTarget(_ target: inout ScrollTarget, context _: TargetContext) {
        if target.rect.minY < 70 {
            if target.rect.minY < 35 {
                target.rect.origin = .zero
            } else {
                target.rect.origin = .init(x: 0, y: 70)
            }
        }
    }
}
