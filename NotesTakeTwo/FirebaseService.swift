//
//  FirebaseService.swift
//  NotesTakeTwo
//
//  Created by Lars Dam on 14/02/2023.
//

import Foundation
import Firebase

class FirebaseService{
    
    private var dataBase = Firestore.firestore()
    private let notes = "notes"
    
    func getNotesFromDB(completion: @escaping ([Dictionary<String, Any>]?, Error?) -> Void){
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
        
    
    func addNoteToDB(dbNote:String, dbHeader:String){
        
        let newDocument = dataBase.collection(notes).document()
        var dataDictionaryMap = [String:String]()
        
        dataDictionaryMap["text"] = dbNote
        newDocument.setData(["text":dbNote])
        
    }
    
    
    
    
}



