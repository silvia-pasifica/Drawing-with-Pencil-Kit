//
//  ContentView.swift
//  Drawing Pencil Kit
//
//  Created by Silvia Pasica on 06/06/23.
//

import SwiftUI
import PencilKit


struct ContentView: View {

    var body: some View {
        Home()
    }
}

    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    @State var canvas = PKCanvasView()
    @State var isDraw = true
    @State var color : Color = .black
    @State var type : PKInkingTool.InkType = .pencil
    @State var colorPicker = false
    
    var body: some View{
        NavigationView{
            DrawingView(canvas: $canvas, isDraw: $isDraw, type: $type, color: $color)
                .navigationTitle("Drawing")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: Button(action: {
                    //saving image
                    SaveImage()
                }, label: {
                    Image(systemName: "square.and.arrow.down.fill")
                        .font(.title)
                }), trailing: HStack(spacing: 15){
                    Button(action: {
                        //eraase tool
                        isDraw = false
                    }){
                        Image(systemName: "pencil.slash")
                            .font(.title)
                    }
                    //menu for inktype and color
                    Menu {
                        //color picker
                        Button(action:{
                            colorPicker.toggle()
                        }){
                            Label {
                                Text("Color")
                            } icon: {
                                Image(systemName: "eyedropper.full")
                            }
                        }
                        
                        Button(action: {
                            isDraw = true
                            type = .pencil
                        }){
                            Label {
                                Text("Pencil")
                            } icon: {
                                Image(systemName: "pencil")
                            }
                        }
                        
                        Button(action: {
                            isDraw = true
                            type = .pen
                        }){
                            Label {
                                Text("Pen")
                            } icon: {
                                Image(systemName: "pencil.tip")
                            }
                        }
                        
                        Button(action: {
                            isDraw = true
                            type = .marker
                        }){
                            Label {
                                Text("Marker")
                            } icon: {
                                Image(systemName: "highlighter")
                            }
                        }
                        
                    }label: {
                        Image(systemName: "circle.hexagonpath")
                            .font(.title)
                    }
                    
                })
                .sheet(isPresented: $colorPicker) {
                    ColorPicker("Pick Color", selection: $color)
                        .padding()
                }
        }
    }
    
    func SaveImage(){
        //getting image from canvas
        let image = canvas.drawing.image(from: canvas.drawing.bounds, scale: 1)
        
        //saving to album
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}

struct DrawingView: UIViewRepresentable{
    //to capture drawing for saving into albums
    @Binding var canvas: PKCanvasView
    @Binding var isDraw : Bool
    @Binding var type : PKInkingTool.InkType
    @Binding var color : Color
    
    var ink: PKInkingTool{
        PKInkingTool(type, color: UIColor(color))
    }
    let eraser = PKEraserTool(.bitmap)
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.drawingPolicy = .anyInput //bisa pencilOnly
        canvas.tool = isDraw ? ink : eraser
        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        //updating tool when ever main view updates
        uiView.tool = isDraw ? ink : eraser
        
    }
}
