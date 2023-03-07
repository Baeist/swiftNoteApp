//
//  ContentView.swift
//  NotesTakeTwo
// A list of text notes
// Button to add new empty note
// Click on a note leads to detail view:
// Shows all the text in an editable text view
// Shows an image (if there is one)
// Button to get image from photo library
// Button to save the text and image
// Button to delete the image

//  Created by Lars Dam on 14/02/2023.
//

import SwiftUI
import Foundation
import Firebase
import UIKit
import PhotosUI

struct ContentView: View {
    
    @ObservedObject var firebaseService = fbService
    
    
    var body: some View {
        
        VStack {
            
            Button("Tilføj ny note") {
                
                
                firebaseService.addNoteToDB(dbNote: "Write here")
                
            }
            
            
            NavigationView{
                
                List($firebaseService.noteList){ note in
                    HStack{
                        if note.hasImage.wrappedValue{
                            
                            Image(uiImage: note.noteImage.wrappedValue ?? UIImage(systemName: "photo.circle.fill")!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20, height: 20)
                            
                            // .offset(x: 140)
                        }else{
                            Image(systemName: "photo.circle.fill")
                        }
                            NavigationLink
                            {
                                NoteWriter(textInput: note.textContent, note: note)
                            }
                        label:
                            {
                                
                                Text(note.textContent.wrappedValue)
                               
                            }
                            
                        }
                    
                    
                }
                .navigationTitle("Noter")
            }
        }
        .padding(10)
        
        //  firebaseService.addNoteToDB(dbNote: "checking")
    }
}
    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


