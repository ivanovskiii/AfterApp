//
//  NotificationView.swift
//  AfterApp
//
//  Created by Gorjan Ivanovski on 28.8.23.
//

import SwiftUI

struct NotificationView: View {
    
    let user: User
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @ObservedObject var userViewModel: UserViewModel
    
    var currentUser: User? {
        authenticationViewModel.currentUser
    }

    var friendRequestUsers: [User] {
        guard let currentUser = currentUser else {
            return []
        }
        return userViewModel.users.filter { currentUser.friendRequests.contains($0.id) }
    }
    
    var body: some View {
        VStack {
            Text("Notifications")
                .padding()
                .font(Font.custom("Shrikhand-Regular", size: 24))
                .foregroundColor(Color("AfterBeige"))
                .padding(.horizontal)
            
            if(friendRequestUsers.isEmpty){
                Spacer()
                Text("You don't have any notifications!")
                    .padding()
                    .foregroundColor(Color("AfterBeige"))
                    .fontWidth(.expanded)
                    .padding(.horizontal)
                Spacer()
            } else{
                List(friendRequestUsers) { user in
                    HStack{
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25)
                            .padding(.trailing, 20)
                            .foregroundColor(Color("AfterBeige"))
                        Text("@\(user.username)")
                            .fontWidth(.expanded)
                            .foregroundColor(Color("AfterBeige"))
                            .frame(height: 40)
                        
                        Spacer()
                        
                        HStack{
                            Button{
                                userViewModel.acceptFriendRequest(authenticationViewModel.currentUser!, user)
                            } label: {
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 18)
                                    .foregroundColor(.green)
                                    .padding(.trailing, 15)
                            }.buttonStyle(.borderless)
                            Button{
                                userViewModel.declineFriendRequest(authenticationViewModel.currentUser!, user)
                            } label:{
                                Image(systemName: "xmark")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 18)
                                    .foregroundColor(.red)
                            }.buttonStyle(.borderless)
                        }.padding()
                            .frame(alignment: .trailing)
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color("AfterDarkGray"))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color("AfterDarkGray"))
    }
}


struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView(user: User(id: "1", username: "jooohn1", email: "john@mail.com", friends: [],
                                          friendRequests: []), userViewModel: UserViewModel())
    }
}
