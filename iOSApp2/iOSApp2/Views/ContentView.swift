//
//  ContentView.swift
//  iOSApp2
//
//  Created by Maryam Hina on 2025-02-07.
//


import SwiftUI

struct ContentView: View {
    @StateObject var huntStore = HuntStore() 
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Text("Scavenger Hunt")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Image(systemName: "map")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.blue)
                
                Text("Find hidden items at local businesses to win prizes!")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding()

                NavigationLink(destination: HuntView().environmentObject(huntStore)) {
                    Text("Start Hunt")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 40)
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(HuntStore()) 
    }
}
