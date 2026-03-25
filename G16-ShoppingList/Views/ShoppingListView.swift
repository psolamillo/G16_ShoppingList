import SwiftUI
import SwiftData

struct ShoppingListView: View {
    // Database access and state
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ShoppingItem.name) private var allItems: [ShoppingItem]
    @Query(sort: \Category.name) private var categories: [Category]
    
    @State private var showingAddItem = false // Controls the pop-up sheet
    
    let tealColor = Color(red: 0.31, green: 0.51, blue: 0.57)
    let coralColor = Color(red: 0.91, green: 0.38, blue: 0.29)
    let lightGray = Color(white: 0.92)
    let darkerGray = Color(white: 0.85)
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack(spacing: 16) {
                Image(systemName: "line.3.horizontal")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("Shopping List")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            .foregroundColor(.white)
            .padding()
            .background(tealColor)
            
            ScrollView {
                VStack(spacing: 0) {
                    //  Group items by their Category
                    ForEach(categories) { category in
                        let categoryItems = allItems.filter { $0.categoryName == category.name }
                        
                        categoryHeader(title: category.name)
                        
                        // List the actual items saved in this category
                        ForEach(categoryItems) { item in
                            listItem(
                                title: item.name,
                                price: String(format: "$%.2f", item.price),
                                quantity: item.quantity
                            )
                        }
                        
                        // Add Item Button inside the category
                        Button(action: { showingAddItem = true }) {
                            addItemButton()
                        }
                        
                        // Category Subtotal
                        let subtotal = categoryItems.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
                        subtotalRow(amount: String(format: "$%.2f", subtotal))
                    }
                    
                    Divider()
                        .padding(.vertical, 8)
                    
                    // Global Grand Total
                    let grandTotal = allItems.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
                    HStack {
                        Spacer()
                        Text("Total: \(String(format: "$%.2f", grandTotal))")
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                    .padding()
                    .background(Color.white)
                }
            }
        }
        .background(Color.white.ignoresSafeArea())
        // Present the Add Item screen as a sheet
        .sheet(isPresented: $showingAddItem) {
            AddItemView()
        }
    }
    
    private func categoryHeader(title: String) -> some View {
        HStack {
            Text(title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Spacer()
        }
        .padding()
        .background(coralColor)
    }
    
    private func listItem(title: String, price: String, quantity: Int) -> some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text(title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    HStack(spacing: 4) {
                        Text("Qty:")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        Text("\(quantity)")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(darkerGray)
                            .cornerRadius(4)
                    }
                }
                
                Spacer()
                
                Text(price)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
            }
            .padding()
            .background(lightGray)
            
            Divider()
        }
    }
    
    private func addItemButton() -> some View {
        HStack {
            Spacer()
            Image(systemName: "plus.circle")
            Text("Add Item")
            Spacer()
        }
        .foregroundColor(coralColor)
        .padding()
        .background(lightGray)
    }
    
    private func subtotalRow(amount: String) -> some View {
        HStack {
            Spacer()
            Text("Subtotal: \(amount)")
                .fontWeight(.bold)
                .foregroundColor(.black)
        }
        .padding()
        .background(Color.white)
    }
}

#Preview {
    ShoppingListView()
        .modelContainer(for: [Category.self, ShoppingItem.self], inMemory: true)
}
