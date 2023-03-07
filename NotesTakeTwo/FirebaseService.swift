//
//  FirebaseService.swift
//  NotesTakeTwo
//
//  Created by Lars Dam on 14/02/2023.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseStorage
import UIKit
var fbService = FirebaseService() // global scope, used like singleton

class FirebaseService: ObservableObject{
    
    private var dataBase = Firestore.firestore()
    let storage = Storage.storage()
    
    private let notes = "notes"
    @Published var noteList = [Note]()
    
    
    
    var image: UIImage? = UIImage(named: "catPicture.png")
    
    
    
    init(){
        loadDatabase()
    }
    
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
    
    func downloadImage(note:Note, completion: @escaping (UIImage?) -> Void){
        let imageRef = storage.reference(withPath: note.id)
        imageRef.getData(maxSize: 5000000){ data, error in
            
            if error == nil{
                completion(UIImage(data:data!))
                
            }else{
                print("something went wrong with image download")
                
            }
            
        }
    }
   
    func loadDatabase(){
        dataBase.collection(notes).addSnapshotListener{ snap, error in
            if error == nil {
                
                if let s = snap{
                    self.noteList.removeAll()
                    for doc in s.documents{
                        
                        if let textStr = doc.data()["text"] as? String,
                           let hasImage = doc.data()["hasImage"] as? Bool
                        {
                                
                            let n = Note(id: doc.documentID,  textContent: textStr, hasImage: hasImage)
                            if n.hasImage{
                                self.downloadImage(note: n){foundImage in
                                    let n2 = Note(id: doc.documentID,  textContent: textStr, hasImage: hasImage, noteImage: foundImage!)
                                    self.noteList.append(n2)
                                }
                            }else{
                                self.noteList.append(n)
                                
                                }
                            }
                        }
                    }
                    
                }
             else{
                 if let e = error{
                     print("failure: \(e)")
                 }
            }
        }
    }
    
    func addNoteToDB(dbNote:String){
        
        let newDocument = dataBase.collection(notes).document()
        var dataDictionaryMap = [String:Any]()
        
        dataDictionaryMap["text"] = dbNote
        dataDictionaryMap["hasImage"] = false
        // dataDictionaryMap["header"] = dbHeader
        
        newDocument.setData(dataDictionaryMap)
        
    }
    
    func updateNote(note:Note){
        if note.hasImage {
            uploadImageWithNote(note: note)
        }
        else{
            deleteImageFromNote(note: note)
        }
        
        let document = dataBase.collection(notes).document(note.id)
        var data = [String:Any]()
        data["text"] = note.textContent
        data["hasImage"] = note.hasImage
        document.setData(data)
        
    }
    
    func uploadImageWithNote(note:Note){
        
        if let image = note.noteImage{
            let imgData = image.jpegData(compressionQuality: 1.0)!
            let imageReference = storage.reference().child(note.id)
            let metaData = StorageMetadata()
            
            metaData.contentType = "image/jpeg"
            imageReference.putData(imgData, metadata: metaData){meta, error in
                
                if error == nil {
                    print("successfully uploaded image")
                }
                else{
                    print("image upload failed \(String(describing: error))")
                }
                
            }
        }
        
    }
    
    func deleteImageFromNote(note: Note){
        let imageReference = storage.reference().child(note.id)
        imageReference.delete { error in
            if error == nil{
                print("deleted image")
            }else{
                print("failed to delete image \(String(describing: error))")
            }
        }
    }
    
    
}



