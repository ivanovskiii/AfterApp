//
//  UserRepository.swift
//  AfterApp
//
//  Created by Gorjan Ivanovski on 28.8.23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class UserRepository: ObservableObject {
    @Published var users: [User] = []

    private let store = Firestore.firestore()

        init() {
            fetchAllUsers()
            print("called init")
        }
    
    func update(_ user: User) {
            if let index = users.firstIndex(where: { $0.id == user.id }) {
                users[index] = user
            }
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
    
    func acceptFriendRequest(_ currentUser: User, _ targetUser: User) {
        // Remove the current user from the friend requests of the target user
        let updatedFriendRequests = targetUser.friendRequests.filter { $0 != currentUser.id }

        // Add the current user to the friends of the target user
        let updatedFriends = targetUser.friends + [currentUser.id]

        // Remove the target user from the friend requests of the current user (if exists)
        let updatedCurrentUserFriendRequests = currentUser.friendRequests.filter { $0 != targetUser.id }

        // Add the target user to the friends of the current user
        let updatedCurrentUserFriends = currentUser.friends + [targetUser.id]

        // Update both users' friend requests and friends in the Firestore documents
        store.collection("user").document(targetUser.id).updateData([
            "friendRequests": updatedFriendRequests,
            "friends": updatedFriends
        ]) { [weak self] error in
            if let error = error {
                print("Error accepting friend request for target user: \(error)")
            } else {
                print("Friend request accepted for target user!")
                
                // Update current user's data
                self?.store.collection("user").document(currentUser.id).updateData([
                    "friendRequests": updatedCurrentUserFriendRequests,
                    "friends": updatedCurrentUserFriends
                ]) { error in
                    if let error = error {
                        print("Error updating current user data: \(error)")
                    } else {
                        print("Current user's friend data updated!")
                    }
                }
            }
        }
    }


    
    func declineFriendRequest(_ currentUser: User, _ targetUser: User) {
        // Remove the current user from the friend requests of the target user
        let updatedFriendRequests = targetUser.friendRequests.filter { $0 != currentUser.id }

        // Update the target user's friend requests in the Firestore document
        store.collection("user").document(targetUser.id).updateData([
            "friendRequests": updatedFriendRequests
        ]) { error in
            if let error = error {
                print("Error declining friend request: \(error)")
            } else {
                print("Friend request declined successfully!")
            }
        }
    }


}

