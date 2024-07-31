//
//  ChallengeMainViewModel.swift
//  TeemonDeo
//
//  Created by TEO on 7/31/24.
//

import SwiftUI




class ChallengeMainViewModel: ObservableObject{
    
    @Published var challenges: [Challenge] = []
    //@Published var challengeUser: ChallengeUser = ChallengeUser()
    
    let fireStoreChallengeManager = FireStoreChallengeManager()
    

//    func fetchUserData() {
//        challengeUser = UserManager.shared.getUser(userId:fireStoreChallengeManager.userId ?? "")
//
//    }
    
    // READ
    func loadChallnege() {
        fireStoreChallengeManager.fetchChallenges()
        challenges = fireStoreChallengeManager.challenges
    }
    
    // CREATE
    func uploadChallenge(challenge: Challenge) {
        fireStoreChallengeManager.addChallenge(challenge: challenge)
    }
    

    
}
