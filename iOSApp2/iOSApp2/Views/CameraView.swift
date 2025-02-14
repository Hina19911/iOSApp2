//
//  CameraView.swift
//  iOSApp2
//
//  Created by Maryam Hina on 2025-02-11.
//

import SwiftUI
import UIKit

struct CameraView: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var item: HuntItem
    @Environment(\.presentationMode) var presentationMode

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: CameraView

        init(parent: CameraView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                Task { @MainActor in
                    self.parent.image = uiImage
                    self.parent.item.imageData = uiImage.jpegData(compressionQuality: 0.8) // ✅ Save Image Data
                }
            }

            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    @MainActor
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        picker.view.backgroundColor = .black
        picker.modalPresentationStyle = .fullScreen
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}


#Preview {
    @State var previewImage: UIImage? = nil
       @State var previewItem = HuntItem(name: "Golden Key", isFound: false)

       return CameraView(image: $previewImage, item: $previewItem)
}
/*import SwiftUI
 import PhotosUI

 struct HuntItemDetail: View {
     @Binding var item: HuntItem
     @State private var selectedItem: PhotosPickerItem? = nil
     @State private var selectedImage: UIImage? = nil
     @State private var showCamera = false

     var body: some View {
         VStack {
             if let image = selectedImage ?? item.image {
                 Image(uiImage: image)
                     .resizable()
                     .scaledToFit()
                     .frame(height: 300)
                     .clipShape(RoundedRectangle(cornerRadius: 10))
                     .padding()
                 
                 Button("Remove Photo") {
                     selectedImage = nil
                     item.imageData = nil
                     
                 }
                 .foregroundColor(.red)
                 .padding()
             } else {
                 Text("No Image Selected")
                     .foregroundColor(.gray)
             }
             
             HStack {
                 PhotosPicker("Select from Gallery", selection: $selectedItem, matching: .images)
                     .padding()
                     .buttonStyle(.bordered)
                 
                 Button("Take a Photo") {
                     showCamera = true
                 }
                 .padding()
                 .buttonStyle(.borderedProminent)
             }
         }
         .onChange(of: selectedItem) { newItem in
             Task {
                 if let newItem = newItem, let data = try? await newItem.loadTransferable(type: Data.self) {
                     selectedImage = UIImage(data: data)
                     item.imageData = data // Save image to HuntItem
                 }
             }
         }
         .sheet(isPresented: $showCamera) {
             CameraView(image: $selectedImage, item: $item)
         }
     }
 }

 #Preview {
     struct HuntItemDetailPreview: View {
         @State var previewItem = HuntItem(name: "Golden Key", isFound: false)

         var body: some View {
             HuntItemDetail(item: $previewItem)
         }
     }
     return HuntItemDetailPreview()
 }*/
