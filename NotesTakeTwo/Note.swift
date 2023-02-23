//
//  Note.swift
//  NotesTakeTwo
//
//  Created by Lars Dam on 15/02/2023.
//

import Foundation

class Note: Identifiable{
    
    var id = UUID()
    var header: String
    var textContent: String
    
    init(id: String, header: String, textContent: String) {
        self.id = UUID()
        self.textContent = textContent
        self.header = header
    }
    
}
