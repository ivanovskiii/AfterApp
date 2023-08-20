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
    
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 16), count: 2)
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Image("AfterLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 120)
                .frame(maxWidth: .infinity, alignment: .top)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(albumListViewModel.albums) { album in
                        Text(album.name)
                            .frame(maxWidth: .infinity, minHeight: 180)
                            .background(Color.white) // Optional: Add a background to each grid item
                            .cornerRadius(20)
                            .shadow(radius: 4) // Optional: Add shadow for a card-like appearance
                    }
                }
                .padding()
            }
            
            Button("Add Mock Album") {
                let album = Album(name: "Test Album One", isLocked: true, unlockTime: Date().addingTimeInterval(12 * 3600))
                albumListViewModel.add(album)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color("AfterDarkGray"))
    }
}


struct AlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumListView(albumListViewModel: AlbumListViewModel())
    }
}
