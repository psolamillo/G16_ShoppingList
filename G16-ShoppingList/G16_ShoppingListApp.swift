//
//  G16_ShoppingListApp.swift
//  G16-ShoppingList
//
//  Created by user293649 on 3/24/26.
//

import SwiftUI
import SwiftData

@main
struct G16_ShoppingListApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
        }
        .modelContainer(for: [Category.self, ShoppingItem.self])
    }
}
