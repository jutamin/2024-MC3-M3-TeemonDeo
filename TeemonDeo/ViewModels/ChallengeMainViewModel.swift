//
//  ChallengeMainViewModel.swift
//  TeemonDeo
//
//  Created by TEO on 8/1/24.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth

class ChallengeMainViewModel: ObservableObject {
    @Published var challenges: [Challenge] = []
    @Published var challengeUser: ChallengeUser? = nil

    @Published var completedChallengeCount: Int = 0
    @Published var userId = Auth.auth().currentUser?.uid

    let fireStoreChallengeManager = FireStoreChallengeManager()

    // READ
    // - ChallengeUser
    func loadChallengerUser(){
        Task {
            let challnegeUser = try await fireStoreChallengeManager.fetchUser()
            DispatchQueue.main.async {
                self.challengeUser = challnegeUser
            }
        }
    }
    
    // READ
    func loadChallenge() {
        Task {
            do {
                let fetchedChallenges = try await fireStoreChallengeManager.fetchChallenges()
                DispatchQueue.main.async {
                    self.challenges = fetchedChallenges
                    print(self.challenges)
                }
            } catch {
                print("Error loading challenges: \(error)")
            }
        }
    }

    
    // CREATE
    func uploadChallenge(challenge: Challenge) {
        Task {
            do {
                try await fireStoreChallengeManager.addChallenge(challenge: challenge)
                //await loadChallenge() // 새로운 챌린지를 추가한 후 목록을 다시 불러옵니다.
            } catch {
                print("Error uploading challenge: \(error)")
                // 여기에 에러 처리 로직을 추가할 수 있습니다.
            }
        }
    }
    
    func countChallenge() -> Int {
        return self.challenges.count
    }
    
    func countCompletedChallenge(challenge: Challenge)/* -> Int*/ {
        if challenge.isChallengeSucceed {
            completedChallengeCount += 1
        }
    }

}
