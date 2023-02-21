//
//  ContentView.swift
//  WhiteBoardApp
//
//  Created by hiba on 21/2/2023.
//

import SwiftUI
import PencilKit

func dismissKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}


struct ContentView: View {
   
    @State var isClicked : Bool = false
    @State var textButton : String = "plus"

    @State var drawView : Bool = false
    @State var textView : Bool = false

 @StateObject var vm = DrawingViewModel()
    
    
    var body: some View {
        NavigationView{
            VStack{
                     ChosesButton
                    .padding(.vertical , 10)
               ZStack {
                   if textView{
                       PKCanvasRepresentationTextView(canvas: $vm.canvas,  toolPicker: $vm.toolPicker)
                         
                    }
                   if drawView && !vm.image.isEmpty {
                       PKCanvasRepresentation(imageData: $vm.image, canvas: $vm.canvas,  toolPicker: $vm.toolPicker)
                    }
                }
               .frame(maxWidth: .infinity ,maxHeight: .infinity, alignment: .center)
                .fullScreenCover(isPresented: $vm.showImgePicker, onDismiss: nil) {
                    ImagePicker(imageData: $vm.image, showPicker: $vm.showImgePicker)
                        .ignoresSafeArea()
                }
                .padding()

            }
        }
 
    }

}


extension ContentView {
    
    private var ChosesButton: some View {
        ZStack{
            if isClicked {
                ZStack{
     
                    Rectangle()
                        .foregroundColor(.black)
                        .frame(width: 45 ,height: 45)
                        .overlay {
                            Image(systemName: "pencil")
                                .imageScale(.large)
                                .foregroundColor(.white)
                        }
                        .cornerRadius(50)
                        .offset(x:-60 , y: 10)
                        .onTapGesture {
                            isClicked = false
                            textButton = "pencil"
                            textView = true
                            drawView = false
                            vm.cancelImageEditing()
                        }
                    
                    Rectangle()
                        .foregroundColor(.black)
                        .frame(width: 45 ,height: 45)
                        .overlay {
                            Image(systemName: "photo")
                                .imageScale(.large)
                                .foregroundColor(.white)
                        }
                        .cornerRadius(50)
                        .offset(x:-30 , y: 55)
                        .onTapGesture {
                            vm.showImgePicker.toggle()
                            textButton = "photo"
                            isClicked = false
                            drawView = true
                            textView = false
                        
                        }
                    
                    Rectangle()
                        .foregroundColor(.black)
                        .frame(width:45 ,height: 45)
                        .overlay {
                            Image(systemName: "square.and.arrow.down")
                                .imageScale(.large)
                                .foregroundColor(.white)
                        }
                        .cornerRadius(50)
                        .offset(x:30 , y: 55)
                        .onTapGesture {
                            vm.SaveImage()
                            isClicked = false
                        }
                   
                    
                    Rectangle()
                        .foregroundColor(.black)
                        .frame(width:45 ,height: 45)
                        .overlay {
                            Image(systemName: "xmark")
                                .imageScale(.large)
                                .foregroundColor(.white)
                        }
                        .cornerRadius(50)
                        .offset(x:60 , y: 10)
                        .onTapGesture {
                            vm.cancelImageEditing()
//                            vm.image = Data(count: 0)
//                            vm.canvas = PKCanvasView()
                            isClicked = false
                        }
                    
                }
            }
            
            Rectangle()
                .foregroundColor(.blue)
                .frame(width: 55 ,height: 55)
                .overlay {
                    withAnimation{
                        Image(systemName: isClicked ? "plus" : textButton)
                            .transition(.scale)
                            .imageScale(.large)
                            .foregroundColor(.white)
                    }
                }
                .cornerRadius(50)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 1)) {
                        isClicked.toggle()
                    }
                }
            
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
