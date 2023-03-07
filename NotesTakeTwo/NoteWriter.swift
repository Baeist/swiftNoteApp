//
//  NoteWriter.swift
//  NotesTakeTwo
//
//  Created by Lars Dam on 16/02/2023.
//

import Foundation
import SwiftUI
import PhotosUI

struct NoteWriter: View{
    @State private var selectedImage: PhotosPickerItem? = nil
    @State private var usedImage: UIImage?
    @Binding var textInput: String
    @Binding var note: Note
    
    var body: some View {
        
        NavigationStack{
            
        
            VStack{
                Image(uiImage: usedImage ?? UIImage(systemName: "photo.circle.fill")!)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .position(x:200, y:0)
                TextField("Skrive felt", text: $textInput, axis: .vertical)
                    .offset(y:-300)
                    
                    .padding(10)
                HStack{
                    
                    Button("Slet billede"){
                        note.noteImage = nil
                        note.hasImage = false
                        usedImage = nil
                    }
                
                    Button("Gem"){
                        note.textContent = textInput
                        fbService.updateNote(note: note)
                    }
                }
            }
        }
        
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                PhotosPicker(selection: $selectedImage, matching: .images, photoLibrary: .shared()){
                    Text("Vælg et billede")
                }
            }
        }
        .onChange(of: selectedImage) { image in
            Task(priority: .background){
                
                if let data = try? await image?.loadTransferable(type: Data.self){
                    note.noteImage = UIImage(data: data)
                    usedImage = note.noteImage
                    note.hasImage = true
                }
            }
        }
        .onAppear(){
            if note.hasImage{
                fbService.downloadImage(note: note){ foundImage in
                    usedImage = foundImage
                }
            }
        }
    }
}

