//
//  ChallengeRecordViewModel.swift
//  TeemonDeo
//
//  Created by TEO on 8/7/24.
//

import SwiftUI
import Foundation
import FirebaseStorage
import FirebaseFirestore
import FirebaseStorage
import Firebase
import FirebaseFirestoreSwift

struct TempRecord: Identifiable, Codable, Hashable {
    var id: String
    var imageData: String
    var recordImage: String
    var recordText: String
    var recordChallengeText: String
    var recordDate: String

    init(from challengeRecord: ChallengeRecord) {
        self.id = challengeRecord.id
        self.imageData = "" // 필요한 경우 기본값 설정
        self.recordImage = challengeRecord.recordImage
        self.recordText = challengeRecord.recordText
        self.recordChallengeText = challengeRecord.recordChallengeText
        self.recordDate = challengeRecord.recordDate
    }
    
}
class ChallengeRecordViewModel: ObservableObject {
    @Published var recordCount: Int = 0
    
    var challengeId: String = ""
    var records: [ChallengeRecord] = []
    var tempRecords: [TempRecord] = []

    //@Published var recordUrl: URL = URL
    @Published var recordUrl: String = ""
    
    let fireStoreChallengeManager = FireStoreChallengeManager()
    let fireStoreRecordManager = FireStoreRecordManager()
    

    // 비동기적으로 이미지 URL을 가져오는 함수
    func retrieveImageUrl(imageId: String) async -> String? {
        let ref = Storage.storage().reference().child("images/\(imageId).jpg")
        do {
            let url = try await ref.downloadURL()
            return url.absoluteString
        } catch {
            print("Failed to retrieve image URL:", error.localizedDescription)
            return nil
        }
    }

    // 비동기적으로 레코드를 로드하고 이미지 URL을 업데이트하는 함수
    func loadRecords(challengeId: String) async {
        do {
            // 레코드와 이미지를 비동기적으로 가져오기
            let recordsData = try await fireStoreRecordManager.fetchRecords(challengeId: challengeId)
            
            // TempRecord 객체 생성
            var tempRecords = recordsData.map { TempRecord(from: $0) }
            
            // 이미지 URL 업데이트
            for index in tempRecords.indices {
                let imageId = tempRecords[index].recordImage // TempRecord가 imageId 속성을 가진다고 가정
                if let imageUrl = await retrieveImageUrl(imageId: imageId) {
                    tempRecords[index].imageData = imageUrl // TempRecord가 imageUrl 속성을 가진다고 가정
                }
            }
            
            // 메인 큐에서 레코드 수 업데이트
            DispatchQueue.main.async {
                self.records = recordsData
                self.tempRecords = tempRecords
                self.recordCount = self.records.count
            }
        } catch {
            print("loadRecords ERROR:", error.localizedDescription)
        }
    }


    
}
