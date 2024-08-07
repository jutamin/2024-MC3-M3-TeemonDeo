//
//  File.swift
//  TeemonDeo
//
//  Created by TEO on 8/4/24.
//

import SwiftUI
import Foundation


class CertifyingViewModel: ObservableObject {
    @Published var recordCount: Int = 0
    @Published var recordId: String = UUID().uuidString
    
    var challengeId: String = ""
    var records: [ChallengeRecord] = []


    private let fireStorageManager = FireStorageManager()
    private let fireStoreRecordManager = FireStoreRecordManager()
    let fireStoreChallengeManager = FireStoreChallengeManager()


    func uploadImg(challengeId: String, recordMemo: String, recordChallenegeText: String, recordDate: String, willUploadImg: UIImage?) async throws {
        fireStorageManager.uploadImage(image: willUploadImg)
        let challengeRecord = ChallengeRecord(id: recordId, recordImage: fireStorageManager.imageId, recordText: recordMemo, recordChallengeText: recordChallenegeText, recordDate: recordDate)
        try await fireStoreRecordManager.addRecord(challengeId: challengeId, challengeRecord: challengeRecord)
    }
    
    
    func loadRecords(challengeId: String) async {
        do{
            self.records = try await fireStoreRecordManager.fetchRecords(challengeId: challengeId)
            DispatchQueue.main.async {
                self.recordCount = self.records.count
            }
        } catch {
            print("loadRecords ERROR")
        }
    }
    
    
}
