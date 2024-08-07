//
//  File.swift
//  TeemonDeo
//
//  Created by TEO on 8/4/24.
//

import SwiftUI
import Foundation


class CertifyingViewModel: ObservableObject {
    
    @Published var recordId: String = UUID().uuidString
    //@Published var challengeRecord: ChallengeRecord = ChallengeRecord(id: recordId, recordImage: "", recordText: "")
    
    private let fireStorageManager = FireStorageManager()
    private let fireStoreRecordManager = FireStoreRecordManager()
    

    func uploadImg(challengeId: String, recordMemo: String, recordChallenegeText: String, recordDate: String, willUploadImg: UIImage?) async throws {
        fireStorageManager.uploadImage(image: willUploadImg)
        let challengeRecord = ChallengeRecord(id: recordId, recordImage: fireStorageManager.imageId, recordText: recordMemo, recordChallengeText: recordChallenegeText, recordDate: recordDate)
        try await fireStoreRecordManager.addRecord(challengeId: challengeId, challengeRecord: challengeRecord)
    }
}
