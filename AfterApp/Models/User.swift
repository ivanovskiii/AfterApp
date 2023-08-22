//
//  User.swift
//  AfterApp
//
//  Created by Gorjan Ivanovski on 22.8.23.
//

import Foundation

struct User: Identifiable, Codable{
    let id: String
    let name: String
    let surname: String
    let email: String
}
