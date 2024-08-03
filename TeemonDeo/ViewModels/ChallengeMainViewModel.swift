//
//  ChallengeMainViewModel.swift
//  TeemonDeo
//
//  Created by TEO on 8/1/24.
//

import Foundation
import SwiftUI


class ChallengeMainViewModel: ObservableObject {
    
    @Published var challenges: [Challenge] = []
    
    let fireStoreChallengeManager = FireStoreChallengeManager()
    
    // READ
    func loadChallenge() {
        Task {
            do {
                let fetchedChallenges = try await fireStoreChallengeManager.fetchChallenges()
                DispatchQueue.main.async {
                    self.challenges = fetchedChallenges
                }
            } catch {
                print("Error loading challenges: \(error)")
                // 여기에 에러 처리 로직을 추가할 수 있습니다.
                // 예: 사용자에게 알림을 보여주거나 로그를 남기는 등
            }
        }
    }
    
    // CREATE
    func uploadChallenge(challenge: Challenge) {
        Task {
            do {
                try await fireStoreChallengeManager.addChallenge(challenge: challenge)
                await loadChallenge() // 새로운 챌린지를 추가한 후 목록을 다시 불러옵니다.
            } catch {
                print("Error uploading challenge: \(error)")
                // 여기에 에러 처리 로직을 추가할 수 있습니다.
            }
        }
    }
}
