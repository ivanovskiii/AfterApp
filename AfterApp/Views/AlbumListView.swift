//
//  ContentView.swift
//  AfterApp
//
//  Created by Gorjan Ivanovski on 30.4.23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase

struct AlbumListView: View {
    
    @ObservedObject var albumListViewModel: AlbumListViewModel
    
    var body: some View {
        ZStack() {
            Image("AfterLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 120)
                .frame(maxWidth: .infinity, alignment: .top)
            
            List(albumListViewModel.albums) { album in
                Text(album.name)
            }
            
            Button("Add Mock Album"){
                let album = Album(name: "Test Album One", isLocked: true, unlockTime: Date().addingTimeInterval(12 * 3600))
                albumListViewModel.add(album)
            }
            
        }
        .frame(height: 80)
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color("AfterDarkGray"))
    }
}

struct AlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumListView(albumListViewModel: AlbumListViewModel())
    }
}
