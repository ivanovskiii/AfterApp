//
//  Photo.swift
//  AfterApp
//
//  Created by Gorjan Ivanovski on 20.8.23.
//

import Foundation
import UIKit
import FirebaseFirestoreSwift
import FirebaseFirestore

struct Photo: Identifiable, Codable{
    var id: String
    var imageURL: String
}
