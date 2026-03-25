import SwiftUI

struct ShoppingListView: View {
    let tealColor = Color(red: 0.31, green: 0.51, blue: 0.57)
    let coralColor = Color(red: 0.91, green: 0.38, blue: 0.29)
    let lightGray = Color(white: 0.92)
    let darkerGray = Color(white: 0.85)
    
    var body: some View {
        VStack(spacing: 0) {
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
                    //Example Categories
                    categoryHeader(title: "Food")
                    
                    listItem(title: "ListItem1", price: "$50")
                    listItem(title: "ListItem1", price: "$50")
                    listItem(title: "ListItem1", price: "$50")
                    
                    addItemButton()
                    subtotalRow(amount: "$150")
                    
                    categoryHeader(title: "Cleaning")
                    
                    listItem(title: "ListItem1", price: "$50")
                    listItem(title: "ListItem1", price: "$50")
                    listItem(title: "ListItem1", price: "$50")
                    
                    addItemButton()
                    subtotalRow(amount: "$150")
                    
                    Divider()
                        .padding(.vertical, 8)
                    
                    HStack {
                        Spacer()
                        Text("Total: $300")
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                    .padding()
                    .background(Color.white)
                }
            }
        }
        .background(Color.white.ignoresSafeArea())
    }
    
    // subviews to reuse ui
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
    
    private func listItem(title: String, price: String) -> some View {
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
                        
                        Text("Label")
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
}
