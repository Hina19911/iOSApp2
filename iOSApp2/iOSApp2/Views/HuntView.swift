//
//  HuntView.swift
//  iOSApp2
//
//  Created by Maryam Hina on 2025-02-07.
//

/*import SwiftUI

struct HuntView: View {
    @StateObject var huntStore = HuntStore()  // 👈 Now using the HuntStore!

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Scavenger Hunt")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Find and capture photos of hidden items to earn prizes!")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding()

                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(huntStore.items) { item in
                            HuntItemRow(item: item, huntStore: huntStore)  // 👈 Pass full item data
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HuntView()
}*/
/*import SwiftUI
import Foundation

struct HuntView: View {
    @EnvironmentObject var huntStore: HuntStore
    @State private var showWinningScreen = false
    @State private var selectedItem: HuntItem? // ✅ Tracks which item gets a photo
        @State private var selectedImage: UIImage? = nil
    @State private var showCamera = false
    
    var allItemsFound: Bool {
        huntStore.items.allSatisfy { $0.isFound }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .white]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            VStack(spacing: 25) {
                Text("Scavenger Hunt")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(radius: 3)
                
                Text("Find and capture photos of hidden items to earn prizes!")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundColor(.white)
                
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach($huntStore.items) { $item in // a binding reference
                            HuntItemRow(item: $item)
                                .environmentObject(huntStore)
                                .background(Color.white)
                                .cornerRadius(2)
                                .padding(.horizontal)
                        }
                    }
                }
                // 📸 Camera Button
                                Button(action: {
                                    showCamera = true
                                }) {
                                    Label("Open Camera", systemImage: "camera")
                                        .padding()
                                        .background(Color.blue.opacity(0.2))
                                        .cornerRadius(8)
                                }
                                .padding()
                                .sheet(isPresented: $showCamera) {
                                    CameraView(image: .constant(nil), item: .constant(HuntItem(name: "Placeholder")))
                                        .edgesIgnoringSafeArea(.all)
                                }
                
                // 🏆 Navigate to the WinningScreen when all items are found
                if allItemsFound {
                    Button(action: {
                        showWinningScreen = true  //Trigger navigation
                    }) {
                        Text("View Prize 🏆")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 40)
                    .fullScreenCover(isPresented: $showWinningScreen) {
                        WinningScreen()
                    }
                }
            }
        }
    }
}

#Preview {
    HuntView()
        .environmentObject(HuntStore())  //  Ensure HuntStore is passed
}*/

import SwiftUI
import Foundation

struct HuntView: View {
    @EnvironmentObject var huntStore: HuntStore
    @State private var showWinningScreen = false
    @State private var selectedItem: HuntItem? // ✅ Tracks which item gets a photo
    @State private var selectedImage: UIImage? = nil
    @State private var showCamera = false
    @State private var showGallery = false  // ✅ Track if gallery is open
    
    var allItemsFound: Bool {
        huntStore.items.allSatisfy { $0.isFound }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .white]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            VStack(spacing: 25) {
                Text("Scavenger Hunt")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(radius: 3)
                
                Text("Find and capture photos of hidden items to earn prizes!")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundColor(.white)
                
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach($huntStore.items) { $item in // ✅ Uses binding reference
                            HuntItemRow(item: $item)
                                .environmentObject(huntStore)
                                .background(Color.white)
                                .cornerRadius(2)
                                .padding(.horizontal)
                        }
                    }
                }
                
                // 📸 Camera Button
                Button(action: {
                    showCamera = true
                }) {
                    Label("Open Camera", systemImage: "camera")
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(8)
                }
                
                .sheet(isPresented: $showCamera) {
                    CameraView(image: .constant(nil), item: .constant(HuntItem(name: "Placeholder")))
                        .edgesIgnoringSafeArea(.all)
                }
                
                // 🖼 Gallery Button 📂
                Button(action: {
                    showGallery = true
                }) {
                    Label("Open Gallery", systemImage: "photo.on.rectangle")
                        .padding()
                        .background(Color.purple.opacity(0.2))
                        .cornerRadius(8)
                }
              
                .sheet(isPresented: $showGallery) {
                    PhotoPickerView(image: $selectedImage)  // ✅ Open image picker
                }
                
                // 🏆 Navigate to the WinningScreen when all items are found
                if allItemsFound {
                    Button(action: {
                        showWinningScreen = true  // ✅ Trigger navigation
                    }) {
                        Text("View Prize 🏆")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 40)
                    .fullScreenCover(isPresented: $showWinningScreen) {
                        WinningScreen()
                    }
                }
            }
        }
    }
}

#Preview {
    HuntView()
        .environmentObject(HuntStore())  //  Ensure HuntStore is passed
}

