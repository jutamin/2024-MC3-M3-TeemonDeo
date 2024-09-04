//
//  UserManager.swift
//  TeemonDeo
//
//  Created by 원주연 on 7/31/24.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserManager {
    static let shared = UserManager()
    
    private init() { }
    
    private let userDB = Firestore.firestore()

    /// User 데이터  return
    func getUser(userId: String) async throws -> ChallengeUser {
        try await userDB.collection("user").document(userId).getDocument(as: ChallengeUser.self)
    }

    
    /// Firestore User 생성
    func createNewUser(user: ChallengeUser) async throws {
        let userIdDB = userDB.collection("user")
        
        let query = userIdDB.whereField("userId", isEqualTo: user.userId)
        
        if try await query.getDocuments().documents.isEmpty {
            print("userId 중복 안 됨. creatNewUser 실행")
            try userDB.collection("user").document(user.userId).setData(from: user)
        } else {
            print("userId 중복됨. creatNewUser 실행 안 함")
        }
    }
    
    /// Firestore User 수정
    func updateUser(user: ChallengeUser) async throws {
        //추가
        
        //
        try userDB.collection("user").document(user.userId).setData(from: user)
    }
    
}
