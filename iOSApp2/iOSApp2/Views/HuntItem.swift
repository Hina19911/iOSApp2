//
//  StructVsClass.swift
//  iOSApp2
//
//  Created by Maryam Hina on 2025-02-07.
//

import SwiftUI
import Foundation

//  the HuntItem struct
struct HuntItem: Identifiable, Codable {
    let id = UUID()
    var name: String
    var isFound: Bool = false
    var imageData: Data? // ✅ Stores image as Data
    
    var image: UIImage? { // ✅ Converts Data to UIImage
        if let data = imageData {
            return UIImage(data: data)
        }
        return nil
    }
}
//  HuntStore to Manage
class HuntStore: ObservableObject {
    @Published var items: [HuntItem] = [
        HuntItem(name: "Golden Key", isFound: false),
        HuntItem(name: "Magic Hat", isFound: false),
        HuntItem(name: "Secret Book", isFound: false),
        HuntItem(name: "Ancient Map", isFound: false),
        HuntItem(name: "Mystic Ring", isFound: false),
        HuntItem(name: "Phantom Lantern", isFound: false)
    ] {
        didSet {
            saveToUserDefaults()  // Save progress whenever items change
        }
    }

    //  Load saved progress when app starts
    init() {
        loadFromUserDefaults()
    }

    //  Toggle the 'isFound' status of an item
    func toggleFound(item: HuntItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isFound.toggle()
            saveToUserDefaults()
        }
    }

    //  Save hunt progress
    private func saveToUserDefaults() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: "HuntItems")
        }
    }

    //  Load hunt progress
    private func loadFromUserDefaults() {
        if let savedData = UserDefaults.standard.data(forKey: "HuntItems"),
           let decodedItems = try? JSONDecoder().decode([HuntItem].self, from: savedData) {
            items = decodedItems
        }
    }
}
