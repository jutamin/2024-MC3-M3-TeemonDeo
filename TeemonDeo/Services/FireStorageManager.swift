//
//  FireStorageManager.swift
//  TeemonDeo
//
//  Created by TEO on 8/4/24.
//


import SwiftUI
import Foundation
import FirebaseStorage

class FireStorageManager {
    var recordImageUrl: String = ""
    var imageId: String = UUID().uuidString

    func uploadImage(image: UIImage?) {
        guard let image = image, let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Failed to get image data")
            return
        }
        
        let storageRef = Storage.storage().reference().child("images/\(imageId).jpg")
        
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Upload failed: \(error.localizedDescription)")
                return
            }
            
            storageRef.downloadURL { url, error in
                if let error = error {
                    print("Failed to get download URL: \(error.localizedDescription)")
                    return
                }
                
                if let url = url {
                    self.recordImageUrl = url.absoluteString
                }
            }
        }
    }
    
    

    
}
