//
//  AlbumView.swift
//  AfterApp
//
//  Created by Gorjan Ivanovski on 23.8.23.
//

import SwiftUI

struct AlbumView: View {

    let album: Album
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            
            Text("\(album.name)")
                .padding()
                .frame(maxWidth: .infinity, alignment: .top)
                .font(Font.custom("Shrikhand-Regular", size: 24))
                .foregroundColor(Color("AfterBeige"))
            
            Spacer()
            
            VStack {
                
                if (album.isLocked == true){
                    
                    Image(systemName: "lock.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
                        .foregroundColor(Color("AfterBeige"))
                    Text("Roll locked until:")
                        .foregroundColor(Color("AfterBeige"))
                        .fontWidth(.expanded)
                    Text("\(album.unlockTime.formatted())")
                        .padding(.top, 1)
                        .foregroundColor(Color("AfterBeige"))
                        .fontWidth(.expanded)
                        .fontWeight(.bold)
                    
                } else {
                    AsyncImage(url: URL(string: "https://hws.dev/paul.jpg"))
                }
            }
            
            Spacer()
            
            Button{
               //Add Photo from camera
            } label: {
                HStack {
                    Image(systemName: "camera.fill")
                    Text("Add Photo")
                }
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
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color("AfterDarkGray"))
        
    }
}

struct AlbumView_Previews: PreviewProvider {
    static var previews: some View {
        
        AlbumView(album: Album(
            user: User(id: "1", name: "John", surname: "Doe", email: "john@mail.com"),
            name: "Sample Album",
            isLocked: false,
            unlockTime: Date().addingTimeInterval(12 * 3600),
            isPrivate: false
        ))
    }
}

