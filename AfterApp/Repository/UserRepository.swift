//
//  UserRepository.swift
//  AfterApp
//
//  Created by Gorjan Ivanovski on 28.8.23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserRepository: ObservableObject {
    @Published var users: [User] = []

    private let store = Firestore.firestore()
    
    init(){
        fetchAllUsers()
    }

    func fetchAllUsers() {
        store.collection("user").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching users: \(error)")
                return
            }

            guard let documents = querySnapshot?.documents else {
                print("No users found")
                return
            }

            let users = documents.compactMap { document in
                try? document.data(as: User.self)
            }

            DispatchQueue.main.async {
                self.users = users
            }
        }
    }
    
    func sendFriendRequest(_ currentUser: User, _ targetUser: User) {
//            guard currentUser != nil else {
//                return // Ensure the current user is authenticated
//            }

            // Add the current user to the friend requests of the target user
            let updatedFriendRequests = targetUser.friendRequests + [currentUser.id]

            // Update the target user's friend requests in the Firestore document
            store.collection("user").document(targetUser.id).updateData(["friendRequests": updatedFriendRequests]) { error in
                if let error = error {
                    print("Error sending friend request: \(error)")
                } else {
                    print("Friend request sent successfully!")
                }
            }
        }

}

