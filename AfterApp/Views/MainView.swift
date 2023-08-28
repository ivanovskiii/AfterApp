//
//  MainView.swift
//  AfterApp
//
//  Created by Gorjan Ivanovski on 22.8.23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            AlbumListView(albumListViewModel: AlbumListViewModel(), albumViewModel: AlbumViewModel(),  album: Album(
                user: User(id: "1", username: "joohn1", email: "john@mail.com", friends: [],
                           friendRequests: []),
                name: "Sample Album",
                photos: [Photo(id: "1", imageURL: "bbb")],
                isLocked: false,
                unlockTime: Date().addingTimeInterval(12 * 3600),
                isPrivate: false,
                creationDate: Date()
            ))
                .tabItem {
                    Label("Rolls", systemImage: "film.stack")
                        .fontWidth(.expanded)
                }.fontWidth(.expanded)
            
            FriendsView()
                .tabItem {
                    Label("Friends", systemImage: "person.3")
                        .fontWidth(.expanded)
                }.fontWidth(.expanded)
            
            NotificationView(userViewModel: UserViewModel())
                .tabItem {
                    Label("Notifications", systemImage: "bell")
                        .fontWidth(.expanded)
                }.fontWidth(.expanded)
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                        .fontWidth(.expanded)
                }.fontWidth(.expanded)

        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(AuthenticationViewModel())
    }
}
