//
//  DrawingOnImageScreen.swift
//  WhiteBoardApp
//
//  Created by hiba on 21/2/2023.
//


import SwiftUI
import PencilKit

struct PKCanvasRepresentation : UIViewRepresentable {
    @Binding var imageData : Data
    @Binding var canvas : PKCanvasView
    @Binding var toolPicker : PKToolPicker
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.drawingPolicy = .anyInput
        canvas.isOpaque = false
        canvas.backgroundColor = .clear
        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        if let image = UIImage(data: imageData){
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 250)
            imageView.clipsToBounds = true

            let subView = canvas.subviews[0]
            subView.addSubview(imageView)
            subView.sendSubviewToBack(imageView)
            
            toolPicker.setVisible(true, forFirstResponder: canvas)
            toolPicker.addObserver(canvas)
            canvas.becomeFirstResponder()
        }
    }
    
}


