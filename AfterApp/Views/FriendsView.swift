//
//  FriendsView.swift
//  AfterApp
//
//  Created by Gorjan Ivanovski on 23.8.23.
//

import SwiftUI

struct FriendsView: View {
    
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @ObservedObject var userViewModel: UserViewModel
    @State private var isShowingUserListView = false

    var currentUser: User? {
        authenticationViewModel.currentUser
    }
    
    var friends: [User] {
        guard let currentUser = currentUser else {
            return []
        }
        return userViewModel.users.filter { currentUser.friends.contains($0.id) }
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 15) {
                
                ZStack {
                    Text("Friends")
                        .padding()
                        .font(Font.custom("Shrikhand-Regular", size: 24))
                        .foregroundColor(Color("AfterBeige"))
                        .padding(.horizontal)
                    
                    Button{
                        isShowingUserListView.toggle()
                    } label: {
                        Image(systemName: "person.badge.plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25)
                    }
                    .padding(.leading, 300)
                }
                .sheet(isPresented: $isShowingUserListView){
                    UserListView()
                }
                
                if (friends.isEmpty){
                    Spacer()
                    Text("It seems a bit lonely here...")
                        .padding()
                        .foregroundColor(Color("AfterBeige"))
                        .fontWidth(.expanded)
                        .padding(.horizontal)
                    Spacer()
                } else{
                    List(friends) { friend in
                        NavigationLink (destination: UserView(user: friend, authenticationViewModel: AuthenticationViewModel(), albumListViewModel: AlbumListViewModel()),
                                        label: {
                            HStack{
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25)
                                .padding(.trailing, 20)
                                .foregroundColor(Color("AfterBeige"))
                            Text("@\(friend.username)")
                                .fontWidth(.expanded)
                                .foregroundColor(Color("AfterBeige"))
                                .frame(height: 40)
                        }
                        })
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color("AfterDarkGray"))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity , alignment: .top)
        .background(Color("AfterDarkGray"))
        }
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView(userViewModel: UserViewModel())
    }
}
