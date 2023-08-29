//
//  NotificationView.swift
//  AfterApp
//
//  Created by Gorjan Ivanovski on 28.8.23.
//

import SwiftUI

struct NotificationView: View {
    
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
            Text("Notificationsss")
                .padding()
                .font(Font.custom("Shrikhand-Regular", size: 24))
                .foregroundColor(Color("AfterBeige"))
                .padding(.horizontal)
            
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
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color("AfterDarkGray"))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color("AfterDarkGray"))
    }
}


struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView(userViewModel: UserViewModel())
    }
}
