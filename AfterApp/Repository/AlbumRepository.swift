//
//  AlbumRepository.swift
//  AfterApp
//
//  Created by Gorjan Ivanovski on 20.8.23.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

final class AlbumRepository: ObservableObject{
    private let store = Firestore.firestore()
    private let path = "albums"
    @Published var albums: [Album] = []
    
    init(){
        get()
    }
    
    func get(){
        store.collection(path).addSnapshotListener { (snapshot, error) in
            if let error = error{
                print(error)
                return
            }
            self.albums = snapshot?.documents.compactMap {
                try? $0.data(as: Album.self)
            } ?? []
        }
    }
    
    func add(_ album: Album){
        do{
            _ = try store.collection(path).addDocument(from: album)
        } catch{
            fatalError("Adding album failed!")
        }
    }
    
}
