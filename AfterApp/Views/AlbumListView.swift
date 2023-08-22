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
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @State private var isShowingAlbumAddSheet = false
    
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
                    Button() {
                        isShowingAlbumAddSheet.toggle()
                    } label: {
                        VStack(alignment: .center, spacing: 10){
                            Text("New Roll")
                                .font(Font.custom("Shrikhand-Regular", size: 18))
                            Image(systemName: "plus.circle")
                        }
                    }
                    .sheet(isPresented: $isShowingAlbumAddSheet){
                        NewAlbumSheetView(albumListViewModel: AlbumListViewModel())
                    }
                    .frame(maxWidth: .infinity, minHeight: 180)
                    .background(Color.gray)
                    .cornerRadius(20)
                    .shadow(radius: 20)
                    ForEach(albumListViewModel.albums) { album in
                        if (album.user.id == authenticationViewModel.currentUser?.id){
                            Text(album.name)
                                .font(Font.custom("Shrikhand-Regular", size: 18))
                                .frame(maxWidth: .infinity, minHeight: 180)
                                .background(Color.gray)
                                .cornerRadius(20)
                                .shadow(radius: 20)
                        }
                    }
                }
                .padding()
            }.preferredColorScheme(.dark)
            
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color("AfterDarkGray"))
    }
}


struct AlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumListView(albumListViewModel: AlbumListViewModel())
            .environmentObject(AuthenticationViewModel())
    }
}
