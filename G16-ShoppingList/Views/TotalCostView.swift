import SwiftUI
import SwiftData

struct TotalCostView: View {
    // Fetch all items currently in the database
    @Query private var items: [ShoppingItem]
    
    @State private var taxRate: String = "13"
    
    // Compute the Subtotal by summing all items (Price * Quantity)
    var subtotal: Double {
        items.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
    }
    
    // Calculate Tax based on the user-inputted rate
    var taxAmount: Double {
        let rate = Double(taxRate) ?? 0.0
        return subtotal * (rate / 100.0)
    }
    
    // Final Total
    var totalCost: Double {
        subtotal + taxAmount
    }

    let tealColor = Color(red: 0.31, green: 0.51, blue: 0.57)
    let lightPurple = Color(red: 0.91, green: 0.90, blue: 0.94)
    let borderColor = Color(red: 0.89, green: 0.87, blue: 0.92)
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            ZStack {
                HStack {
                    Button(action: {
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                 Text("Total Cost")
                     .font(.headline)
                     .fontWeight(.semibold)
                     .foregroundColor(.white)
             }
             .padding()
             .background(tealColor)
             
             ScrollView {
                 VStack(spacing: 24) {
                     VStack(spacing: 0) {
                         // Subtotal Row
                         costRow(title: "Subtotal", value: subtotal)
                         
                         // Tax Rate Input
                         HStack {
                             Text("Tax Rate (%)")
                                 .fontWeight(.semibold)
                                 .foregroundColor(Color(white: 0.2))
                             Spacer()
                             TextField("0", text: $taxRate)
                                 .multilineTextAlignment(.trailing)
                                 .keyboardType(.decimalPad)
                                 .frame(width: 60)
                                 .padding(.vertical, 8)
                                 .padding(.horizontal, 12)
                                 .background(Color.white)
                                 .cornerRadius(6)
                                 .overlay(
                                     RoundedRectangle(cornerRadius: 6)
                                         .stroke(borderColor, lineWidth: 1)
                                 )
                         }
                         .padding()
                         
                         Divider().padding(.horizontal)
                         
                        // Calculated Tax Amount
                        costRow(title: "Tax Amount", value: taxAmount)
                        
                        // Final Total Cost
                        HStack {
                            Text("Total Cost")
                                .fontWeight(.bold)
                            Spacer()
                            Text(String(format: "$%.2f", totalCost))
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(tealColor)
                    }
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
                    
                    // Calculation Disclaimer
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Tax Calculation")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(Color(white: 0.2))
                        
                        Text("The selected tax rate will be applied to all applicable categories")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .lineSpacing(5)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(lightPurple)
                    .cornerRadius(12)
                }
                .padding()
             }
          }
          .background(Color.white.ignoresSafeArea())
      }
      
      private func costRow(title: String, value: Double) -> some View {
          VStack(spacing: 0) {
              HStack {
                  Text(title)
                      .fontWeight(.semibold)
                      .foregroundColor(Color(white: 0.2))
                  Spacer()
                  Text(String(format: "$%.2f", value))
                      .font(.title3)
                      .fontWeight(.bold)
                      .foregroundColor(.black)
              }
              .padding()
              Divider().padding(.horizontal)
          }
      }
  }
