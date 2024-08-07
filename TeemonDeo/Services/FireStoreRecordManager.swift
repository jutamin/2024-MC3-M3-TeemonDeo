//
//  FireStoreRecordManager.swift
//  TeemonDeo
//
//  Created by TEO on 8/5/24.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift



class FireStoreRecordManager {
    var records: [ChallengeRecord] = []
    var challengeUser: ChallengeUser? = nil

    var userId: String? {
        Auth.auth().currentUser?.uid
    }
    var challengeId: String? = nil
    
    
    private let db = Firestore.firestore()
    
    func fetchUser() async throws -> ChallengeUser {
        guard let userId = userId else {
            throw NSError(domain: "FireStoreRecordManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "User ID not available"])
        }
        
        /// ChallengeUser타입의 snapshot
        let snapshot = try await db.collection("user").document(userId).getDocument(as: ChallengeUser.self)
        self.challengeUser = snapshot
        return snapshot
    }
    
    
    func addRecord(challengeId: String?, challengeRecord: ChallengeRecord) async throws {
        guard let userId = userId else {
            throw NSError(domain: "FireStoreRecordManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "User ID not available"])
        }
        guard let challengeId = challengeId else {
            throw NSError(domain: "FireStoreRecordManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "challengeId not available"])
        }
        
        let data: [String: Any] = [
            "id": challengeRecord.id,
            "recordImage": challengeRecord.recordImage,
            "recordText": challengeRecord.recordText,
        ]
        
        try await db.collection("user").document(userId)
            .collection("challenges").document(challengeId)
            .collection("records").document(challengeRecord.id).setData(data)
    }
    

    
    func fetchRecords(challengeId: String?) async throws -> [ChallengeRecord] {
        guard let userId = userId else {
            throw NSError(domain: "FireStoreRecordManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "User ID not available"])
        }
        guard let challengeId = challengeId else {
            throw NSError(domain: "FireStoreRecordManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "challengeId not available"])
        }
        
        let snapshot = try await db.collection("user").document(userId).collection("challenges").document(challengeId).collection("records").getDocuments()
        
        self.records.removeAll()
        
        for document in snapshot.documents {
            let recordId: String = document.documentID
            
            let docData = document.data()
            let recordImage: String = docData["recordImage"] as? String ?? ""
            let recordText: String = docData["recordText"] as? String ?? ""
            
            let challenge = ChallengeRecord(id: recordId, recordImage: recordImage, recordText: recordText, recordChallengeText: "", recordDate: "")
            
            self.records.append(challenge)
        }
        
        return self.records
    }
    

}
