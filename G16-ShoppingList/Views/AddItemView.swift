import SwiftUI
import SwiftData

struct AddItemView: View {
    // Access the database context and the dismiss action
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    var itemToEdit: ShoppingItem? = nil
    
    // Fetch categories from database so the user can select one
    @Query(sort: \Category.name) private var categories: [Category]
    
    let tealColor = Color(red: 0.31, green: 0.51, blue: 0.57)
    let lightPurple = Color(red: 0.91, green: 0.90, blue: 0.94)
    let borderColor = Color(red: 0.89, green: 0.87, blue: 0.92)
    
    @State private var itemName: String = ""
    @State private var price: String = ""
    @State private var quantity: String = ""
    @State private var selectedCategory: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Cancel")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                
                Text(itemToEdit == nil ? "Add Item" : "Edit Item")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .padding()
             .background(tealColor)
             
             ScrollView {
                 VStack(alignment: .leading, spacing: 20) {
                     
                     inputField(title: "Item Name", placeholder: "Enter item name", text: $itemName)
                     
                     inputField(title: "Price", placeholder: "0.00", text: $price, alignment: .trailing)
                         .keyboardType(.decimalPad)
                     
                     inputField(title: "Quantity", placeholder: "Enter quantity", text: $quantity)
                         .keyboardType(.numberPad)
                     
                     // Category Picker linked to database categories
                     VStack(alignment: .leading, spacing: 8) {
                         Text("Category")
                             .font(.subheadline)
                             .fontWeight(.bold)
                             .foregroundColor(Color(white: 0.2))
                         
                         Picker("Select a category", selection: $selectedCategory) {
                             Text("Select a category").tag("")
                             ForEach(categories) { category in
                                 Text(category.name).tag(category.name)
                             }
                         }
                         .pickerStyle(.menu)
                         .frame(maxWidth: .infinity)
                         .padding(8)
                         .background(Color.white)
                         .cornerRadius(8)
                         .overlay(
                             RoundedRectangle(cornerRadius: 8)
                                 .stroke(borderColor, lineWidth: 1)
                         )
                     }
                     
                      HStack(spacing: 16) {
                          Button(action: {
                              dismiss()
                          }) {
                              Text("Cancel")
                                  .fontWeight(.bold)
                                  .foregroundColor(.black)
                                  .frame(maxWidth: .infinity)
                                  .padding()
                                  .background(lightPurple)
                                  .cornerRadius(8)
                          }
                          
                          Button(action: {
                              saveItem() // Trigger the database save
                          }) {
                              Text(itemToEdit == nil ? "Save" : "Update")
                                  .fontWeight(.bold)
                                  .foregroundColor(.white)
                                  .frame(maxWidth: .infinity)
                                  .padding()
                                  .background(tealColor)
                                  .cornerRadius(8)
                          }
                          // Validation: Disable button if fields are empty
                          .disabled(itemName.isEmpty || price.isEmpty || selectedCategory.isEmpty)
                      }
                      .padding(.top, 10)
                  }
                  .padding()
              }
          }
          .background(Color.white.ignoresSafeArea())
          .onAppear{
              if let item = itemToEdit{
                  itemName = item.name
                  price = String(format: "%.2f", item.price)
                  quantity = "\(item.quantity)"
                  selectedCategory = item.categoryName
              }
          }
      }
    
     private func saveItem() {
         // Convert inputs to correct data types
         let itemPrice = Double(price) ?? 0.0
         let itemQty = Int(quantity) ?? 1
         
         // Create the model instance
         if let item = itemToEdit{
             item.name = itemName
             item.price = itemPrice
             item.quantity = itemQty
             item.categoryName = selectedCategory
             
         }else {
             let newItem = ShoppingItem(
                name: itemName,
                price: itemPrice,
                quantity: itemQty,
                categoryName: selectedCategory
             )
             
             // Insert into SwiftData context
             modelContext.insert(newItem)
         }
         
         // Close the view
         dismiss()
     }
     
     private func inputField(title: String, placeholder: String, text: Binding<String>, alignment: TextAlignment = .leading) -> some View {
         VStack(alignment: .leading, spacing: 8) {
             Text(title)
                 .font(.subheadline)
                 .fontWeight(.bold)
                 .foregroundColor(Color(white: 0.2))
             
             TextField(placeholder, text: text)
                 .multilineTextAlignment(alignment)
                 .padding()
                 .background(Color.white)
                 .cornerRadius(8)
                 .overlay(
                     RoundedRectangle(cornerRadius: 8)
                         .stroke(borderColor, lineWidth: 1)
                 )
         }
     }
 }
