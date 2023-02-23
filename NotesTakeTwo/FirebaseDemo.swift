//
//  FirebaseDemo.swift
//  NotesTakeTwo
//
//  Created by Lars Dam on 21/02/2023.
//

import Foundation
import Firebase
import FirebaseStorage
import UIKit

class FirebaseDemo{
    
    private var db = Firestore.firestore()
    private let collection = "notes"
    // @Published var notes = [Note]() // this particular one is published
   
    func addItem(text:String){
        
        let doc = db.collection(collection).document()
        var data = [String:String]()
        
        data["text"] = text
        
        doc.setData(data)
    }
    
    func loadContinuously(){
        db.collection(collection).addSnapshotListener{ snap, error in
            if error == nil {
                
                if let s = snap{
                    
                    for doc in s.documents{
                        
                        if let str = doc.data()["text"] as? String{
                            
                            print(str)
                        //    let n = Note(id: doc.documentID , textContent: <#T##String#>)
                         //   self.notes.append(n)
                        }
                    }
                    
                }
            } else{
                
            }
            
            
        }
    }
    
    
}

/* func getNotesFromDB(completion: @escaping ([Dictionary<String, Any>]?, Error?) -> Void){
    var foundNotes: [Dictionary<String, Any>] = []
    dataBase.collection(notes).getDocuments { (querySnapshot, error) in
        if let error = error {
            completion(nil, error)
        } else {
            for document in querySnapshot!.documents {
                let note = document.data()
                foundNotes.append(note)
            }
            completion(foundNotes, nil)
        }
    }
}
    */
