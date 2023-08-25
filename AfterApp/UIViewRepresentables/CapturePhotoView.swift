//
//  ImagePicker.swift
//  AfterApp
//
//  Created by Gorjan Ivanovski on 25.8.23.
//

import UIKit
import SwiftUI

struct CapturePhotoView: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    var didCaptureImage: (UIImage) -> Void

    func makeUIViewController(context: UIViewControllerRepresentableContext<CapturePhotoView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = false
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<CapturePhotoView>) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}


class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var parent: CapturePhotoView

    init(_ parent: CapturePhotoView) {
        self.parent = parent
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            parent.didCaptureImage(image)
            parent.isPresented = false
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        parent.isPresented = false
    }
}

