import SwiftUI

struct MenuView: View {
    let tealColor = Color(red: 0.31, green: 0.51, blue: 0.57)
    let coralColor = Color(red: 0.91, green: 0.38, blue: 0.29)
    let lightTeal = Color.white.opacity(0.15)
    let separatorColor = Color.white.opacity(0.2)
    
    @State private var selectedMenu: String = "Shopping List"
    
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
                
                HStack {
                    Text("Menu")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.leading, 50)
            }
            .padding()
            .background(tealColor)
            
            Divider()
                .background(separatorColor)
            
            VStack(spacing: 10) {
                menuItem(
                    title: "Shopping List",
                    subtitle: "View and manage your shopping items",
                    isSelected: selectedMenu == "Shopping List"
                )
                
                menuItem(
                    title: "Manage Categories",
                    subtitle: "Create and edit shopping categories",
                    isSelected: selectedMenu == "Manage Categories"
                )
                
                menuItem(
                    title: "Tax Calculator",
                    subtitle: "Calculate total cost with tax",
                    isSelected: selectedMenu == "Tax Calculator"
                )
            }
            
            Spacer()
        }
        .background(tealColor.ignoresSafeArea())
    }
    
    // subviews
    
    private func menuItem(title: String, subtitle: String, isSelected: Bool) -> some View {
        Button(action: {
            selectedMenu = title
        }) {
            HStack(spacing: 0) {
                // selected indicator
                if isSelected {
                    Rectangle()
                        .fill(coralColor)
                        .frame(width: 4, height: 20)
                } else {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(width: 4, height: 20)
                }
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(title)
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Text(subtitle)
                            .font(.footnote)
                            .foregroundColor(Color.white.opacity(0.7))
                    }
                    
                    Spacer()
                    
                    Image(systemName: "arrow.right")
                        .font(.caption)
                        .foregroundColor(Color.white.opacity(0.6))
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
            }
            .background(isSelected ? lightTeal : Color.clear)
        }
        .buttonStyle(PlainButtonStyle())
        .overlay(
            VStack {
                Spacer()
                Divider().background(separatorColor)
            }
        )
    }
}

#Preview {
    MenuView()
}
