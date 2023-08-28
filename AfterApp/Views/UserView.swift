//
//  UserView.swift
//  AfterApp
//
//  Created by Gorjan Ivanovski on 28.8.23.
//

import SwiftUI

struct UserView: View {
    
    let user: User
    @ObservedObject var userViewModel: UserViewModel = UserViewModel()
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 15){
            Text("@\(user.username)")
                .foregroundColor(Color("AfterBeige"))
                .font(Font.custom("Shrikhand-Regular", size: 24))
            
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .foregroundColor(Color("AfterBeige"))
                .padding(.top, 5)
            
            Button{
                userViewModel.sendFriendRequest(authenticationViewModel.currentUser!, user)
            } label: {
                Text("Add Friend")
                    .font(.headline)
                    .foregroundColor(Color("AfterDarkGray"))
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color("AfterBeige"))
                    .cornerRadius(10)
                    .fontWidth(.expanded)
            }
            .padding(.horizontal)
            .padding(.bottom, 30)
            .padding(.top, 20)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color("AfterDarkGray"))
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: User(id: "1", username: "John", email: "john@mail.com", friends: [], friendRequests: []), authenticationViewModel: AuthenticationViewModel())
    }
}
