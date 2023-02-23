//
//  FirebaseService.swift
//  NotesTakeTwo
//
//  Created by Lars Dam on 14/02/2023.
//

import Foundation
import Firebase
import FirebaseStorage
import UIKit

class FirebaseService: ObservableObject{
    
    private var dataBase = Firestore.firestore()
    private let notes = "notes"
    
    @Published var noteList = [Note]()
    
    private var storage = Storage.storage()
    
    func uploadImage(){
        
        if let img = UIImage(named: "catPicture"){
            
            let data = img.pngData()! // force unwrap
            let metaData = StorageMetadata()
            metaData.contentType = "image/png"
            let reference = storage.reference().child("catPicture.png")
            reference.putData(data, metadata: metaData){ meta, error in
                if error == nil{
                    print("upload ok")
                } else{
                    print("problem not uploaded")
                }
            }
            
        }
        
    }
    
    func downloadImage(){
        let imageRef = storage.reference(withPath: "cattyPicture.png")
        imageRef.getData(maxSize: 500000000){ data, error in
            
            if error == nil{
                let image = UIImage(data:data!)
                print(image?.description)
            }else{
                print("something went wrong")
            }
            
        }
    }
   
    func loadContinuously(){
        dataBase.collection(notes).addSnapshotListener{ snap, error in
            if error == nil {
                
                if let s = snap{
                    
                    for doc in s.documents{
                        
                        if let textStr = doc.data()["text"] as? String{
                            
                            if let headStr = doc.data()["header"] as? String{
                                
                                let n = Note(id: doc.documentID, header: headStr,  textContent: textStr)
                                self.noteList.append(n)
                            }
                        }
                    }
                    
                }
            } else{
                
            }
            
            
        }
    }
    
    func addNoteToDB(dbNote:String, dbHeader:String){
        
        let newDocument = dataBase.collection(notes).document()
        var dataDictionaryMap = [String:String]()
        
        dataDictionaryMap["text"] = dbNote
        dataDictionaryMap["header"] = dbHeader
        
        newDocument.setData(dataDictionaryMap)
        
    }
    
    
    
    
}



