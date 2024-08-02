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
    
    private let db = Firestore.firestore()
    
    var userId: String? {
        Auth.auth().currentUser?.uid
    }
    
    func addChallenge(challenge: Challenge){
        guard let userId = userId else { return }
        
        db.collection("user").document(userId)
            .collection("challenges").document(challenge.id).setData(["challengeId": challenge.id,
                                                                               "challengeName" : challenge.challengeName,
                                                                               "challengeStartDate" : challenge.challengeStartDate,
                                                                               "challengePeriod" : challenge.challengePeriod,
                                                                               "challengeSpace" : challenge.challengeSpace,
                                                                               "isChallengeSucceed" : challenge.isChallengeSucceed,
                                                                              ])
    }
    
    
    func fetchChallenges() {
        guard let userId = userId else { return }
        
        db.collection("user").document(userId).collection("challenges").getDocuments { (snapshot, error) in
            self.challenges.removeAll()
            
            if let snapshot {
                for document in snapshot.documents{
                    let challengeId: String = document.documentID
                    
                    let docData = document.data()
                    let challengeName: String = docData["challengeName"] as? String ?? ""
                    let challengeStartDate: String = docData["challengeStartDate"] as? String ?? ""
                    let challengePeriod: Int = docData["challengePeriod"] as? Int ?? 0
                    let challengeSpace: String = docData["challengeSpace"] as? String ?? ""
                    let isChallengeSucceed: Bool = docData["isChallengeSucceed"] as? Bool ?? false
                    
                    let challenge: Challenge = Challenge(id: challengeId,
                                                         challengeName: challengeName,
                                                         challengeStartDate: challengeStartDate,
                                                         challengePeriod: challengePeriod,
                                                         challengeSpace: challengeSpace,
                                                         isChallengeSucceed: isChallengeSucceed)
                    
                    
                    self.challenges.append(challenge)
                }
            }
        }
    }
    
    func countChallenge() async throws -> Int {
//        guard let userId = userId else { return }
        
//        let query = try await db.collection("user").document(userId ?? "").collection("challenges").getDocuments().count
        let count = challenges.count
        return(count)
    }
    
    
}


