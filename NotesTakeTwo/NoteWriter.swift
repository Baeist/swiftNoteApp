//
//  NoteWriter.swift
//  NotesTakeTwo
//
//  Created by Lars Dam on 16/02/2023.
//

import Foundation
import SwiftUI

struct NoteWriter: View{
    
    @Binding var textInput: String
    
    var body: some View {
        
        VStack{
            
            TextField("Skrive felt", text: $textInput)
                .padding(10)
            
            Button("Gem"){
                let FB: FirebaseService = FirebaseService()
                FB.addNoteToDB(dbNote: textInput, dbHeader: "EmptyForNow")
                
            }
            
        }
    }
}

