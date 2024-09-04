//
//  FireStoreChallengeManager.swift
//  TeemonDeo
//
//  Created by TEO on 8/1/24.
//


import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift


class FireStoreChallengeManager {
    var challenges: [Challenge] = []
    var challengeUser: ChallengeUser? = nil
    var completedChallenges: [Challenge] = []

    private let db = Firestore.firestore()
    
    var userId: String? {
        Auth.auth().currentUser?.uid
    }
    
    func fetchUser() async throws -> ChallengeUser {
        guard let userId = userId else {
            throw NSError(domain: "FireStoreChallengeManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "User ID not available"])
        }
        
        /// ChallengeUser타입의 snapshot
        let snapshot = try await db.collection("user").document(userId).getDocument(as: ChallengeUser.self)

        self.challengeUser = snapshot
        
        return snapshot
    }
    
    
    func addChallenge(challenge: Challenge) async throws {
        guard let userId = userId else {
            throw NSError(domain: "FireStoreChallengeManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "User ID not available"])
        }
        
        let data: [String: Any] = [
            "challengeId": challenge.id,
            "challengeName": challenge.challengeName,
            "challengeStartDate": challenge.challengeStartDate,
            "challengePeriod": challenge.challengePeriod,
            "challengeSpace": challenge.challengeSpace,
            "isChallengeSucceed": challenge.isChallengeSucceed
        ]
        
        try await db.collection("user").document(userId)
            .collection("challenges").document(challenge.id).setData(data)
    }
    

    
    func fetchChallenges() async throws -> [Challenge] {
        guard let userId = userId else {
            throw NSError(domain: "FireStoreChallengeManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "User ID not available"])
        }
        
        let snapshot = try await db.collection("user").document(userId).collection("challenges").getDocuments()
        
        self.challenges.removeAll()
        
        for document in snapshot.documents {
            let challengeId: String = document.documentID
            
            let docData = document.data()
            let challengeName: String = docData["challengeName"] as? String ?? ""
            let challengeStartDate: String = docData["challengeStartDate"] as? String ?? ""
            let challengePeriod: Int = docData["challengePeriod"] as? Int ?? 0
            let challengeSpace: String = docData["challengeSpace"] as? String ?? ""
            let isChallengeSucceed: Bool = docData["isChallengeSucceed"] as? Bool ?? false
            
            let challenge = Challenge(id: challengeId,
                                      challengeName: challengeName,
                                      challengeStartDate: challengeStartDate,
                                      challengePeriod: challengePeriod,
                                      challengeSpace: challengeSpace,
                                      isChallengeSucceed: isChallengeSucceed)
            
            self.challenges.append(challenge)
            if challenge.isChallengeSucceed {
                self.completedChallenges.append(challenge)
            }
        }
        
        return self.challenges
    }
}
