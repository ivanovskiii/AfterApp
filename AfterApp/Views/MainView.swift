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
                user: User(id: "1", name: "John", surname: "Doe", email: "john@mail.com"),
                name: "Sample Album",
                photos: [Photo(id: "1", imageURL: "bbb")],
                isLocked: false,
                unlockTime: Date().addingTimeInterval(12 * 3600),
                isPrivate: false,
                creationDate: Date()
            ))
                .tabItem {
                    Label("Rolls", systemImage: "film.stack")
                        
                }
            
            FriendsView()
                .tabItem {
                    Label("Friends", systemImage: "person.3")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                        .fontWidth(.expanded)
                }

        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(AuthenticationViewModel())
    }
}
