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
            
            Text("New Roll")
                .foregroundColor(Color("AfterBeige"))
                .font(Font.custom("Shrikhand-Regular", size: 24))
            
            
            Spacer()
            
            TextField("Roll Name", text: $albumName, prompt: Text("Roll Name").foregroundColor(Color("AfterBeige")))
                .foregroundColor(Color("AfterBeige"))
                .autocorrectionDisabled(true)
                .padding(10)
                .frame(height: 55)
                .fontWidth(.expanded)
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.white, lineWidth: 2)
                }
            
            Toggle("Private Roll", isOn: $isPrivate)
                .frame(height: 55)
                .foregroundColor(Color("AfterBeige"))
                .fontWidth(.expanded)
            
            Text("Toggling \"Private Roll\" will prevent other users from seeing it on your profile. You can change this option later.")
                .font(.caption)
                .foregroundColor(Color("AfterBeige"))
            
            
            Spacer()
            
            Button() {
                let album = Album(user: authenticationViewModel.currentUser!, name: albumName, photos: [], isLocked: true, unlockTime: Date().addingTimeInterval(12 * 3600), isPrivate: isPrivate)
                albumListViewModel.add(album)
                let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                    impactMed.impactOccurred()
                print("DEBUG:", album)
                dismiss()
            } label: {
                Text("Create New Roll")
                    .fontWidth(.expanded)
            }.font(.headline)
                .foregroundColor(Color("AfterDarkGray"))
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color("AfterBeige"))
                .cornerRadius(10)
        }.frame(maxHeight: .infinity, alignment: .center)
            .padding()
            .padding(.bottom, 30)
        .background(Color("AfterDarkGray"))

    }
}

struct NewAlbumSheetView_Previews: PreviewProvider {
    static var previews: some View {
        NewAlbumSheetView(albumListViewModel: AlbumListViewModel())
            .environmentObject(AuthenticationViewModel())
    }
}
