//
//  ChallengeRecord.swift
//  TeemonDeo
//
//  Created by TEO on 8/4/24.
//

import Firebase
import FirebaseFirestoreSwift

struct ChallengeRecord: Identifiable, Codable, Hashable {
    var id: String
    var recordImage: String
    var recordText: String
}
