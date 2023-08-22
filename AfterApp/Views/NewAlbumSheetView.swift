//
//  NewAlbumSheetView.swift
//  AfterApp
//
//  Created by Gorjan Ivanovski on 22.8.23.
//

import SwiftUI

struct NewAlbumSheetView: View {
    
    @ObservedObject var albumListViewModel: AlbumListViewModel
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @Environment(\.dismiss) var dismiss
    @State var albumName = ""
    @State var isPrivate = false
    
    
    var body: some View {
        
        VStack{
            
            TextField("Roll Name", text: $albumName, prompt: Text("Roll Name").foregroundColor(Color("AfterBeige")))
                .foregroundColor(Color("AfterBeige"))
                .autocorrectionDisabled(true)
                .padding(10)
                .frame(height: 55)
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.white, lineWidth: 2)
                }
            
            Toggle("Private Roll", isOn: $isPrivate)
                .frame(height: 55)
                .foregroundColor(Color("AfterBeige"))
            
            Text("Toggling \"Private Roll\" will prevent other users from seeing it")
                .font(.footnote)
                .foregroundColor(Color("AfterBeige"))
            
            Divider()
            
            Button() {
                let album = Album(user: authenticationViewModel.currentUser!, name: albumName, isLocked: true, unlockTime: Date().addingTimeInterval(12 * 3600), isPrivate: isPrivate)
                albumListViewModel.add(album)
                let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                    impactMed.impactOccurred()
                print("DEBUG:", album)
                dismiss()
            } label: {
                VStack(alignment: .center, spacing: 10){
                    Text("Save Roll")
                }
            }.font(.headline)
                .foregroundColor(Color("AfterDarkGray"))
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color("AfterBeige"))
                .cornerRadius(10)
        }.frame(maxHeight: .infinity, alignment: .center)
            .padding()
        .background(Color("AfterDarkGray"))

    }
}

struct NewAlbumSheetView_Previews: PreviewProvider {
    static var previews: some View {
        NewAlbumSheetView(albumListViewModel: AlbumListViewModel())
            .environmentObject(AuthenticationViewModel())
    }
}
