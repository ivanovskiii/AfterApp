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
    @ObservedObject var albumListViewModel: AlbumListViewModel
    
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 16), count: 2)
    
    var body: some View {
        VStack(alignment: .center, spacing: 15){
            Text("@\(user.username)")
                .foregroundColor(Color("AfterBeige"))
                .font(Font.custom("Shrikhand-Regular", size: 24))
            
            ScrollView {
                
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .foregroundColor(Color("AfterBeige"))
                    .padding(.top, 5)
                
                if authenticationViewModel.currentUser?.friends.contains(user.id) ?? false {
                    
                    Button{
                        userViewModel.removeFriend(authenticationViewModel.currentUser!, user)
                    } label: {
                        Text("Unfriend")
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
                    
                    Text("\(user.username)'s Rolls")
                        .padding()
                    
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(albumListViewModel.albums.sorted(by: { $0.creationDate > $1.creationDate })) { album in
                            if album.isSharingWithFriends{
                                if (album.user.id == user.id) {
                                    NavigationLink(destination: AlbumView(album: album), label: {
                                        ZStack {
                                            if let firstImageURL = album.getFirstImageURL() {
                                                AlbumBackgroundView(imageURL: firstImageURL, isUnlocked: album.isLocked)
                                                    .frame(height: 180)
                                            } else {
                                                Color.gray
                                                    .cornerRadius(20)
                                                    .frame(height: 180)
                                            }
                                            VStack{
                                                Text(album.name)
                                                    .font(Font.custom("Shrikhand-Regular", size: 24))
                                                    .foregroundColor(Color("AfterBeige"))
                                                    .cornerRadius(20)
                                                    .shadow(radius: 20)
                                                if album.isLocked {
                                                    Image(systemName: "lock.fill")
                                                        .foregroundColor(Color("AfterBeige"))
                                                }
                                            }
                                        }
                                    })
                                }
                            }
                        }
                    }
                    
                    
                } else {
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
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color("AfterDarkGray"))
            
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: User(id: "1", username: "John", email: "john@mail.com", friends: [], friendRequests: []), authenticationViewModel: AuthenticationViewModel(), albumListViewModel: AlbumListViewModel())
    }
}
