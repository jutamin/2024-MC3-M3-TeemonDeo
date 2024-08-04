//
//  File.swift
//  TeemonDeo
//
//  Created by TEO on 8/4/24.
//

import SwiftUI
import Foundation


class CertifyingViewModel: ObservableObject {
    var willUploadImg: UIImage?
    
    private var imgUrl: String = ""
    
    private let fireStorageManager = FireStorageManager()
    private let fireStoreChallengeManager = FireStoreChallengeManager()
    
    //@Published var imgComment: String
    //@Published var imgUrl: String
    //@Published var willUploadImg: UIImage
    //private var willUploadImg: UIImage?

    func uploadImg() {
        fireStorageManager.uploadImage(image: willUploadImg)
        let challengeRecord = ChallengeRecord(id: UUID().uuidString, recordImage: fireStorageManager.imageUrl, recordText: "first")
        // fireStoreChallengeManager.addChallengeRecord(challengeRecord)
        // 이건 풀어야됨!!
    }

}
