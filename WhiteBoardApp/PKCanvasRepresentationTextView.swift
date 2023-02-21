//
//  PKCanvasRepresentationTextView.swift
//  WhiteBoardApp
//
//  Created by hiba on 21/2/2023.
//


import SwiftUI
import PencilKit


struct PKCanvasRepresentationTextView : UIViewRepresentable {
    @Binding var canvas : PKCanvasView
    @Binding var toolPicker : PKToolPicker
    let eraser = PKEraserTool(.bitmap)
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.drawingPolicy = .anyInput
        canvas.isOpaque = false
        canvas.backgroundColor = .clear
        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
            toolPicker.setVisible(true, forFirstResponder: canvas)
            toolPicker.addObserver(canvas)
            canvas.becomeFirstResponder()
    }
}

