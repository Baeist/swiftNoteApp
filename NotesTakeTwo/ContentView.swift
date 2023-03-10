//
//  ContentView.swift
//  NotesTakeTwo
// Create an app "My Personal Notes" which allows the user to:
// Create a new note
// Save notes to Firestore
// mangler Optional: Read from Firestore
//  Created by Lars Dam on 14/02/2023.
//

import SwiftUI
import Foundation
import Firebase
import UIKit

struct ContentView: View {
    
    @ObservedObject var firebaseService = FirebaseService()
    var firebaseDemo = FirebaseDemo()
    
    @State var noteList: [Note] = []
    
    var body: some View {
        
        VStack {
            
            Button("Tilføj ny note") {
                
               // firebaseService.uploadImage()
                
               // firebaseService.downloadImage()
                
                var note: Note = Note(id: "", header: "",textContent: "");
                
                noteList.append(note)
                
            }
            
            
            NavigationView{
                
                List($noteList){ note in
                    
                    NavigationLink
                    {
                        NoteWriter(textInput: note.textContent)
                    }
                label:
                    {
                        Text("Note")
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

/*  firebaseService.getNotesFromDB{(noteList, error) in
 if let error = error {
         print("Error getting notes: \(error)")
     } else {
         print("Retrieved \(noteList.count) notes")
         // Do something with the notes array
     }
         }*/
