import SwiftUI
import SwiftData

struct ManageCategoriesView: View {
    @Environment(\.dismiss) private var dismiss
    //  Database context for inserting/deleting
    @Environment(\.modelContext) private var modelContext
    
    // Live query that updates the UI automatically when data changes
    @Query(sort: \Category.name) private var categories: [Category]
    
    let tealColor = Color(red: 0.31, green: 0.51, blue: 0.57)
    let coralColor = Color(red: 0.91, green: 0.38, blue: 0.29)
    let rowBackground = Color(red: 0.93, green: 0.92, blue: 0.96)
    let borderColor = Color(red: 0.89, green: 0.87, blue: 0.92)

    @State private var newCategory: String = ""

    var body: some View {
        VStack(spacing: 0) {
            
            // Header
            ZStack {
                HStack {
                    Button(action: {
                        // back navigation
                        dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                    }
                    Spacer()
                }

                Text("Manage Categories")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .padding()
            .background(tealColor)

            // Dynamic List from Database
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(categories) { category in
                        categoryRow(category: category)
                        Divider()
                    }
                }
                .background(rowBackground)
            }
            .padding(.bottom, 16)

            // Add New Category Section
            VStack(alignment: .leading, spacing: 12) {
                Text("Add New Category")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.black)

                HStack(spacing: 12) {
                    TextField("Category name", text: $newCategory)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(borderColor, lineWidth: 1)
                        )

                    Button(action: {
                        addCategory()
                    }) {
                        Text("Add")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 14)
                            .background(tealColor)
                            .cornerRadius(8)
                    }
                    // Disable button if text is empty
                    .disabled(newCategory.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
            .padding()

            Spacer()
        }
        .background(Color.white.ignoresSafeArea())
    }
    
    private func addCategory() {
        let name = newCategory.trimmingCharacters(in: .whitespaces)
        if !name.isEmpty {
            let category = Category(name: name)
            modelContext.insert(category) // Saves to database
            newCategory = "" // Clears input
        }
    }
    
    private func categoryRow(category: Category) -> some View {
        HStack {
            Text(category.name)
                .foregroundColor(.black)

            Spacer()

            Button(action: {
                modelContext.delete(category) // Removes from database
            }) {
                Text("Delete")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 6)
                    .background(coralColor)
                    .cornerRadius(6)
            }
        }
        .padding()
        .background(rowBackground)
    }
}

#Preview {
    ManageCategoriesView()
        .modelContainer(for: Category.self, inMemory: true)
}
