//
//  AlbumViewModel.swift
//  AfterApp
//
//  Created by Gorjan Ivanovski on 23.8.23.
//

import Foundation
import UIKit
import SwiftUI

@MainActor
class AlbumViewModel: ObservableObject{
    
    @Published var selectedAlbum: Album?
    @Published var showCamera = false
    @Published var photoRepository = PhotoRepository()
    @Published var albumRepository = AlbumRepository()
    @Published var isAddingPhoto = false

    
    init(){
        self.showCamera = false
    }
    
    func checkUnlocked() -> Bool{
        guard let album = selectedAlbum else {
            return false
        }
               
        let currentTime = Date()
        print("DEBUG: Checking unlocked status.")
        print(album.isLocked && currentTime >= album.unlockTime)
        return album.isLocked && currentTime >= album.unlockTime
    }
    
    func captureAndUploadPhoto() {
        guard let selectedAlbum = selectedAlbum, let photo = capturedPhoto else {
            return
        }
        
        isAddingPhoto = true

        photoRepository.addPhotoToAlbum(album: selectedAlbum, image: photo) { result in
            switch result {
            case .success:
                // Photo added successfully
                DispatchQueue.main.async {
                                self.isAddingPhoto = false
                            }
                print("Photo added successfully!")
            case .failure(let error):
                // Error adding photo
                DispatchQueue.main.async {
                                self.isAddingPhoto = false
                            }
                print("Error adding photo: \(error.localizedDescription)")
            }
        }
    }

    var capturedPhoto: UIImage? {
        didSet {
            if capturedPhoto != nil {
                captureAndUploadPhoto()
            }
        }
    }
    
}
