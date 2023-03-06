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

struct ContentView: View {
    
    @ObservedObject var firebaseService = fbService
    
    
    
    
    var body: some View {
        
        VStack {
            
            Button("Tilføj ny note") {
                
                
                firebaseService.addNoteToDB(dbNote: "Write here")
                
            }
            
            
            NavigationView{
                
                List($firebaseService.noteList){ note in
                    
                    NavigationLink
                    {
                        NoteWriter(textInput: note.textContent, note: note)
                    }
                label:
                    {
                        HStack{
                            
                            Text(note.textContent.wrappedValue)
                            /*
                            Image("catPicture")
                                .resizable()
                                .scaledToFill()
                                .offset(x: 140) */
                             //   .frame(width: 20)
                        }
                        .frame(width: 100, height: 15)
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


