//
//  User.swift
//  AfterApp
//
//  Created by Gorjan Ivanovski on 22.8.23.
//g

import Foundation

struct User: Identifiable, Codable{
    let id: String
    let username: String
    let email: String
    let friends: [String]
    let friendRequests: [String]
}
