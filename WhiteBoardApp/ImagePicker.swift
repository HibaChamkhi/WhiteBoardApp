//
//  ImagePicker.swift
//  WhiteBoardApp
//
//  Created by hiba on 21/2/2023.
//

import Foundation
import SwiftUI
struct ImagePicker: UIViewControllerRepresentable {
 
//    @Binding var image: UIImage?
 
//    private let controller = UIImagePickerController()
    @Binding  var imageData:Data
    @Binding  var  showPicker :Bool
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
 
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 
        let parent: ImagePicker
 
        init(parent: ImagePicker) {
            self.parent = parent
        }
 
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let imageData = (info[.originalImage] as? UIImage)?.pngData() {
                parent.imageData = imageData
                parent.showPicker.toggle()
            }
        }
 
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//            picker.dismiss(animated: true)
            parent.showPicker.toggle()
        }
 
    }
 
    func makeUIViewController(context: Context) -> UIImagePickerController{
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        controller.delegate = context.coordinator
        return controller
    }
 
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
 
    }
 
}


