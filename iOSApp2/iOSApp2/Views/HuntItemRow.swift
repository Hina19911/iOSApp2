//
//  HuntItemRow.swift
//  iOSApp2
//
//  Created by Maryam Hina on 2025-02-07.
//
import SwiftUI

struct HuntItemRow: View {
    @Binding var item: HuntItem
    @EnvironmentObject var huntStore: HuntStore
    // ✅ Uses @EnvironmentObject to match HuntView
    
    var body: some View {
        HStack {
            if let image = item.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            Text(item.name)
                .font(.title3)
                .fontWeight(.medium)
            
            Spacer()
            
            if item.isFound {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            }
            
            Button(action: {
                markAsFound()  // ✅ Calls the function correctly
            }) {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
        .padding(.horizontal, 20)
    }

    // ✅ Function moved outside of body to avoid closure declaration error
    func markAsFound() {
        if let index = huntStore.items.firstIndex(where: { $0.id == item.id }) {
            huntStore.items[index].isFound.toggle()
        }
    }
}


#Preview {
    @State var previewItem = HuntItem(name: "Golden Key", isFound: false) // ✅ Create a @State variable
    
    return HuntItemRow(item: $previewItem) // ✅ Pass as a binding using $
        .environmentObject(HuntStore())
}
