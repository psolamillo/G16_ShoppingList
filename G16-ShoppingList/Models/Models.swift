//
//  Models.swift
//  G16-ShoppingList
//
//  Created by Patrick Millares on 2026-03-25.
//

import Foundation
import SwiftData

@Model
class Category {
    var name: String
    // Link to items; deleting a category deletes its items
    @Relationship(deleteRule: .cascade) var items: [ShoppingItem]?
    
    init(name: String) {
        self.name = name
        self.items = []
    }
}

@Model
class ShoppingItem {
    var name: String
    var price: Double
    var quantity: Int
    var categoryName: String
    
    init(name: String, price: Double, quantity: Int, categoryName: String) {
        self.name = name
        self.price = price
        self.quantity = quantity
        self.categoryName = categoryName
    }
}
