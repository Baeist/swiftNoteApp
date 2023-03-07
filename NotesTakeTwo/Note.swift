//
//  Note.swift
//  NotesTakeTwo
//
//  Created by Lars Dam on 15/02/2023.
//

import Foundation
import UIKit
import SwiftUI

class Note: Identifiable{
    
    var id: String
    // var header: String
    var textContent: String
    var hasImage = false
    var noteImage: UIImage? = nil
    
    init(id: String, textContent: String, hasImage:Bool) {
        self.id = id
        self.textContent = textContent
       // self.header = header
        self.hasImage = hasImage
        
    }
    init(id: String, textContent: String, hasImage:Bool, noteImage:UIImage) {
        self.id = id
        self.textContent = textContent
       // self.header = header
        self.hasImage = hasImage
        self.noteImage = noteImage
    }
}
