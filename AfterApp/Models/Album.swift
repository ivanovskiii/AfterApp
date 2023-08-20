//
//  Album.swift
//  AfterApp
//
//  Created by Gorjan Ivanovski on 20.8.23.
//

import FirebaseFirestoreSwift
import FirebaseFirestore
import Foundation

struct Album: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
//    var photos: [Photo]
    var isLocked: Bool
    var unlockTime: Date
}
