//
//  DrawingViewModel.swift
//  WhiteBoardApp
//
//  Created by hiba on 21/2/2023.
//


import Foundation
import PencilKit
import SwiftUI

class DrawingViewModel: ObservableObject {
    @Published var showImgePicker = false
    
    @Published var image: Data = Data(count: 0)
    @Published var canvas = PKCanvasView()
    
    @Published var toolPicker = PKToolPicker()
    @Published var rect : CGRect = .zero
    
    
    func cancelImageEditing(){
        image = Data(count: 0)
        canvas = PKCanvasView()
    }
    
    func SaveImage(){
        UIGraphicsBeginImageContextWithOptions( CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 200) , false, 1)
        canvas.drawHierarchy(in: CGRect(origin: .zero, size:  CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 200) ), afterScreenUpdates: true)
        let generatedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if let image = generatedImage {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
//        let image = canvas.drawing.image(from: canvas.drawing.bounds, scale: 1)
//        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}
