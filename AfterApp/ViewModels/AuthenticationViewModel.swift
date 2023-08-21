//
//  LoginViewModel.swift
//  AfterApp
//
//  Created by Gorjan Ivanovski on 20.8.23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth
import Firebase

@MainActor
class AuthenticationViewModel: ObservableObject{
    
    @Published var userSession: FirebaseAuth.User?
    //    @Published var currentUser
    
    init(){
        self.userSession = Auth.auth().currentUser
    }
    
    func signIn(withEmail email: String, password: String) async throws{
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
        } catch{
            print("Failed to sign in user \(error.localizedDescription)")
        }
    }
        
    func createAccount(name: String, surname: String, withEmail email: String, password: String) async throws{
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
        } catch{
            print("Failed to create user \(error.localizedDescription)")
        }
        }
        
        func signOut(){
            do{
                try Auth.auth().signOut()
                self.userSession = nil
            } catch{
                print("Error sign out \(error.localizedDescription)")
            }
        }
        
        func fetchUser() async{
            
        }
        
}
