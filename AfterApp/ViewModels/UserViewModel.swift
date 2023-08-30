//
//  UserListViewModel.swift
//  AfterApp
//
//  Created by Gorjan Ivanovski on 28.8.23.
//

import Foundation
import UIKit
import SwiftUI
import Combine

@MainActor
class UserViewModel: ObservableObject{
    
    @Published var userRepository = UserRepository()
    @Published var users: [User] = []

    private var cancellables: Set<AnyCancellable> = []

    init(){
        userRepository.$users
            .assign(to: \.users, on: self)
            .store(in: &cancellables)
        
        
    }
    
    func sendFriendRequest(_ currentUser: User, _ targetUser: User) {
        userRepository.sendFriendRequest(currentUser, targetUser)
    }
    
    func acceptFriendRequest(_ currentUser: User, _ targetUser: User){
        userRepository.acceptFriendRequest(currentUser, targetUser)
    }
    
    func declineFriendRequest(_ currentUser: User, _ targetUser: User){
        userRepository.declineFriendRequest(currentUser, targetUser)
    }
    
    func removeFriend(_ currentUser: User, _ targetUser: User){
        userRepository.removeFriend(currentUser, targetUser)
    }
}
