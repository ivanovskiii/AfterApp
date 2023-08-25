//
//  PhotoRepository.swift
//  AfterApp
//
//  Created by Gorjan Ivanovski on 25.8.23.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseFirestore

final class PhotoRepository: ObservableObject {
    
    func uploadPhotoToStorage(image: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(.failure(PhotoRepositoryError.imageConversionError))
            return
        }

        let storageRef = Storage.storage().reference()
        let imageRef = storageRef.child("images/\(UUID().uuidString).jpg")

        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        imageRef.putData(imageData, metadata: metadata) { metadata, error in
            if let error = error {
                completion(.failure(error))
            } else {
                imageRef.downloadURL { url, error in
                    if let downloadURL = url {
                        completion(.success(downloadURL))
                    } else {
                        completion(.failure(PhotoRepositoryError.downloadURLError))
                    }
                }
            }
        }
    }
    
    func addPhotoToAlbum(album: Album, image: UIImage, completion: @escaping (Result<Void, Error>) -> Void) {
        uploadPhotoToStorage(image: image) { result in
            switch result {
            case .success(let downloadURL):
                let newPhoto = Photo(id: UUID().uuidString, imageURL: downloadURL.absoluteString)
                var updatedPhotos = album.photos
                updatedPhotos.append(newPhoto)
                
                let albumRef = Firestore.firestore().collection("albums").document(album.id ?? "")
                albumRef.updateData(["photos": updatedPhotos.map { ["id": $0.id, "imageURL": $0.imageURL] }]) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(()))
                    }
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

enum PhotoRepositoryError: Error {
    case imageConversionError
    case downloadURLError
}
