//
//  AlbumView.swift
//  AfterApp
//
//  Created by Gorjan Ivanovski on 23.8.23.
//

import SwiftUI
import UIKit

struct AlbumView: View {

    let album: Album
    
    @StateObject private var albumViewModel = AlbumViewModel()

    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            
            Text("\(album.name)")
                .padding()
                .frame(maxWidth: .infinity, alignment: .top)
                .font(Font.custom("Shrikhand-Regular", size: 24))
                .foregroundColor(Color("AfterBeige"))
            
            VStack {
                
                if album.isLocked {
                    
                    ZStack {
                        ScrollView {
                            LazyVGrid(columns: [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)], spacing: 10) {
                                ForEach(album.photos, id: \.id) { photo in
                                    FullScreenImageView(imageURL: photo.imageURL)
                                        .frame(width: (UIScreen.main.bounds.width - 30 - 10) / 2, height: (UIScreen.main.bounds.width - 30 - 10) / 2)
                                        .cornerRadius(10)
                                }
                            }
                            .padding(15)
                        }
                        .blur(radius: 10) // Apply blur effect to the images
                        .saturation(0) // Desaturate the images
                        .disabled(true)

                        ZStack {
                            VStack {
                                Spacer()
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
                                
                                Spacer()

                                Button {
                                    albumViewModel.showCamera = true
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
                                .disabled(albumViewModel.isAddingPhoto)

                                if albumViewModel.isAddingPhoto {
                                    VStack {
                                        ProgressView()
                                        Text("Adding photo to Roll")
                                            .fontWidth(.expanded)
                                            .foregroundColor(Color("AfterBeige"))
                                            .padding(.bottom, 30)
                                    }
                                }
                            }
                        }
                    }
                    
                } else {
                    
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)], spacing: 10) {
                            ForEach(album.photos, id: \.id) { photo in
                                FullScreenImageView(imageURL: photo.imageURL)
                                    .frame(width: (UIScreen.main.bounds.width - 30 - 10) / 2, height: (UIScreen.main.bounds.width - 30 - 10) / 2)
                                    .cornerRadius(10)
                            }
                        }
                        .padding(15)
                    }
                    
                    
                }
            }
        }
        .fullScreenCover(isPresented: $albumViewModel.showCamera) {
            CapturePhotoView(isPresented: $albumViewModel.showCamera) { image in
                                    albumViewModel.capturedPhoto = image // Pass the captured photo
                                }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color("AfterDarkGray"))
        .onAppear {
            albumViewModel.selectedAlbum = album
            Task {
                await albumViewModel.checkAndUpdateLockStatus()
            }
        }
        
    }
}

struct AlbumView_Previews: PreviewProvider {
    static var previews: some View {
        
        AlbumView(
            album: Album(
            user: User(id: "1", username: "joohn1", email: "john@mail.com", friends: [],
                       friendRequests: []),
            name: "Sample Album",
            photos: [Photo(id: "1", imageURL: "bbb")],
            isLocked: false,
            unlockTime: Date().addingTimeInterval(12 * 3600),
            isPrivate: false,
            creationDate: Date()
        )
        )
    }
}

struct FullScreenImageView: View {
    let imageURL: String
    @State private var isPresented = false

    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .cornerRadius(10)
        } placeholder: {
            ProgressView()
        }
        .onTapGesture {
            isPresented.toggle()
        }
        .fullScreenCover(isPresented: $isPresented, content: {
            FullScreenImageViewer(isPresented: $isPresented, imageURL: imageURL)
        })
    }
}


struct FullScreenImageViewer: View {
    @Binding var isPresented: Bool
    let imageURL: String

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack {
                AsyncImage(url: URL(string: imageURL)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                Button(action: {
                    print("tapped")
                    if let uiImage = UIImage(named: imageURL) {
                        sharePhoto(image: uiImage)
                    }
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .padding(.top, 20)
                        .foregroundColor(Color("AfterBeige"))
                }
            }
        }
        .onTapGesture {
            isPresented.toggle()
        }
        .navigationBarHidden(true)
    }

    func sharePhoto(image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 1.0) else {
            return
        }

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let rootViewController = windowScene.windows.first?.rootViewController {
                let activityViewController = UIActivityViewController(activityItems: [data], applicationActivities: nil)
                rootViewController.present(activityViewController, animated: true, completion: nil)
            }
        }

    }

}



