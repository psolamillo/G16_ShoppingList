import SwiftUI

struct ManageCategoriesView: View {
    let tealColor = Color(red: 0.31, green: 0.51, blue: 0.57)
    let coralColor = Color(red: 0.91, green: 0.38, blue: 0.29)
    let rowBackground = Color(red: 0.93, green: 0.92, blue: 0.96)
    let borderColor = Color(red: 0.89, green: 0.87, blue: 0.92)

    @State private var newCategory: String = ""

    //Example data to match the screenshots
    let categories = ["Food", "Medication", "Cleaning Supplies", "Personal Care"]

    var body: some View {
        VStack(spacing: 0) {
            
            ZStack {
                HStack {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                    }
                }

                Text("Manage Categories")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .padding()
            .background(tealColor)

            VStack(spacing: 0) {
                ForEach(categories, id: \.self) { category in
                    categoryRow(name: category)
                    Divider()
                }
            }
            .background(rowBackground)
            .padding(.bottom, 16)

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
                        
                    }) {
                        Text("Add")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 14)
                            .background(tealColor)
                            .cornerRadius(8)
                    }
                }
            }
            .padding()

            Spacer()
        }
        .background(Color.white.ignoresSafeArea())
    }

    // subviews
    
    private func categoryRow(name: String) -> some View {
        HStack {
            Text(name)
                .foregroundColor(.black)

            Spacer()

            Button(action: {
                //
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
}
