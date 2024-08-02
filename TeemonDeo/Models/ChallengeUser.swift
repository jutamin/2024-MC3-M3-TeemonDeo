//
//  User.swift
//  TeemonDeo
//
//  Created by 원주연 on 7/31/24.
//

import Foundation

// userEmail은 나중에 다시 검토합시다..
struct ChallengeUser: Codable, Hashable {
    let userId: String
    let userEmail: String?
    let userNickname: String
    let userTier: Int
    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.userEmail = auth.email
        self.userNickname = "누구길래티몬데오"
        self.userTier = 1
    }
}
