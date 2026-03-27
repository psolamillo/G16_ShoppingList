//
//  ContentView.swift
//  G16-ShoppingList
//
//  Created by user293649 on 3/24/26.
//

import SwiftUI

struct ContentView: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            ShoppingListView()
        } else {
            ZStack {
                Color(red: 0.31, green: 0.51, blue: 0.57)
                    .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(red: 0.91, green: 0.38, blue: 0.29))
                            .frame(width: 90, height: 90)
                        
                        Image(systemName: "cart")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44)
                            .foregroundColor(.white)
                    }
                    
                    Text("Shopping List")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Group 16 Shopping List")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.85))
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
