//
//  AlbumView.swift
//  AfterApp
//
//  Created by Gorjan Ivanovski on 23.8.23.
//

import SwiftUI

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
                
                if albumViewModel.checkUnlocked() {
                    
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
                    
                } else {
                    
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
//                            RoundedRectangle(cornerRadius: 10)
//                                .foregroundColor(Color.clear)
//                                .frame(width: (UIScreen.main.bounds.width) / 1.5, height: (UIScreen.main.bounds.width - 10) / 3)
////                                .frame(height: 200)
//                                .background(
//                                    .thinMaterial, in: RoundedRectangle(cornerRadius: 10))
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
        }
        
    }
}

struct AlbumView_Previews: PreviewProvider {
    static var previews: some View {
        
        AlbumView(
            album: Album(
            user: User(id: "1", name: "John", surname: "Doe", email: "john@mail.com"),
            name: "Sample Album",
            photos: [Photo(id: "1", imageURL: "bbb")],
            isLocked: false,
            unlockTime: Date().addingTimeInterval(12 * 3600),
            isPrivate: false
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

            AsyncImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .global)
                    .onChanged { value in
                        // Handle panning gesture for image
                    }
            )
        }
        .onTapGesture {
            isPresented.toggle()
        }
        .navigationBarHidden(true)
    }
}

