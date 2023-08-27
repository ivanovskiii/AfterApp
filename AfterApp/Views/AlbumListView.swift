import SwiftUI

struct AlbumListView: View {
    @ObservedObject var albumListViewModel: AlbumListViewModel
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @State private var isShowingAlbumAddSheet = false
    @ObservedObject var albumViewModel: AlbumViewModel
    let album: Album
    
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 16), count: 2)
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                VStack(alignment: .center, spacing: 15) {
                    Image("AfterLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .frame(maxWidth: .infinity, alignment: .top)
                        .padding(.top, 5)
                }
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        Button() {
                            isShowingAlbumAddSheet.toggle()
                        } label: {
                            VStack(alignment: .center, spacing: 1){
                                Text("New Roll")
                                    .font(Font.custom("Shrikhand-Regular", size: 24))
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
                        
                        ForEach(albumListViewModel.albums.sorted(by: { $0.creationDate > $1.creationDate })) { album in
                            if (album.user.id == authenticationViewModel.currentUser?.id) {
                                NavigationLink(destination: AlbumView(album: album), label: {
                                    ZStack {
                                        if let firstImageURL = album.getFirstImageURL() {
                                            AlbumBackgroundView(imageURL: firstImageURL, isUnlocked: album.isLocked)
                                                .frame(height: 180)
                                        } else {
                                            Color.gray
                                                .cornerRadius(20)
                                                .frame(height: 180)
                                        }
                                        VStack{
                                            if album.isLocked {
                                                Image(systemName: "lock.fill")
                                                    .foregroundColor(Color("AfterBeige"))
                                            }
                                            Text(album.name)
                                                .font(Font.custom("Shrikhand-Regular", size: 24))
//                                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                .foregroundColor(Color("AfterBeige"))
                                                .cornerRadius(20)
                                                .shadow(radius: 20)
                                        }
                                    }
                                })
                                .contextMenu {
                                    Button(action: {
                                        albumListViewModel.delete(album)
                                    }) {
                                        Label("Delete \(album.name)", systemImage: "trash")
                                    }
                                    .foregroundColor(.red)
                                }
                            }
                        }
                    }
                    .padding()
                }
                .preferredColorScheme(.dark)
                .onAppear{
                    Task{
                        await albumViewModel.checkAndUpdateLockStatus()
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .background(Color("AfterDarkGray"))
        }
    }
}


struct AlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumListView(albumListViewModel: AlbumListViewModel(), albumViewModel: AlbumViewModel(), album: Album(
            user: User(id: "1", name: "John", surname: "Doe", email: "john@mail.com"),
            name: "Sample Album",
            photos: [Photo(id: "1", imageURL: "bbb")],
            isLocked: false,
            unlockTime: Date().addingTimeInterval(12 * 3600),
            isPrivate: false, creationDate: Date()
        ))
            .environmentObject(AuthenticationViewModel())
    }
}

struct AlbumBackgroundView: View {
    let imageURL: String
    let isUnlocked: Bool
    
    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .cornerRadius(20)
                .blur(radius: 10)
                .saturation(isUnlocked ? 0.0 : 1.0)
                .overlay(Color.black.opacity(0.3))
        } placeholder: {
            VStack{
                Color.gray
            }
        }
        .frame(height: 180)
        .cornerRadius(20)
    }
}


