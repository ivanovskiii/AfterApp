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
            AlbumListView(albumListViewModel: AlbumListViewModel())
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
