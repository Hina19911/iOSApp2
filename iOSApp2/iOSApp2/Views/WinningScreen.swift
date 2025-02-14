//
//  WinningScreen.swift
//  iOSApp2
//
//  Created by Maryam Hina on 2025-02-08.
//

import SwiftUI

struct WinningScreen: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.3),
                                                    .white]),
                                startPoint: .topLeading,
                                endPoint:.bottomTrailing)
                           .ignoresSafeArea()
            VStack(spacing: 20) {
                Text("🎉 Congratulations! 🎉")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.yellow)
                    .shadow(radius: 5)

                Text("You found all the items and won the grand prize!")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundColor(.gray)

                Button(action: {
                    // Action to go back to HuntView
                }) {
                    Text("Back to Hunt")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 40)
            }
            .padding()
        }
    }
}

#Preview {
    WinningScreen()
}
