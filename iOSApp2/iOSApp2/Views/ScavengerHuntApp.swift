//
//  ScavengerHuntApp.swift
//  iOSApp2
//
//  Created by Maryam Hina on 2025-02-11.
//
import SwiftUI

@main
struct ScavengerHuntApp: App {
    @StateObject var huntStore = HuntStore() // ✅ Create the environment object

    var body: some Scene {
        WindowGroup {
            HuntView()
                .environmentObject(huntStore) // ✅ Provide it to all child views
        }
    }
}
