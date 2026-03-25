import SwiftUI

struct TotalCostView: View {
    let tealColor = Color(red: 0.31, green: 0.51, blue: 0.57)
    let lightPurple = Color(red: 0.91, green: 0.90, blue: 0.94)
    let borderColor = Color(red: 0.89, green: 0.87, blue: 0.92)
    
    @State private var taxRate: String = "13"
    
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
                        HStack {
                            Text("Subtotal")
                                .fontWeight(.semibold)
                                .foregroundColor(Color(white: 0.2))
                            Spacer()
                            Text("$150.00")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                        .padding()
                        
                        Divider().padding(.horizontal)
                        
                        HStack {
                            Text("Tax Rate (%)")
                                .fontWeight(.semibold)
                                .foregroundColor(Color(white: 0.2))
                            Spacer()
                            TextField("0", text: $taxRate)
                                .multilineTextAlignment(.trailing)
                                .font(.system(size: 16))
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
                        
                        HStack {
                            Text("Tax Amount")
                                .fontWeight(.semibold)
                                .foregroundColor(Color(white: 0.2))
                            Spacer()
                            Text("$19.50")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                        }
                        .padding()
                        
                        HStack {
                            Text("Total Cost")
                                .fontWeight(.bold)
                            Spacer()
                            Text("$169.50")
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
}

#Preview {
    TotalCostView()
}
