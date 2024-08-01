//
//  Challenge.swift
//  TeemonDeo
//
//  Created by TEO on 7/31/24.
//

import Foundation

struct Challenge: Identifiable, Hashable {
    let id: String
    let challengeName: String
    let challengeStartDate: String
    let challengePeriod: Int
    let challengeSpace: String
    let isChallengeSucceed: Bool
}


struct ChallengeRecord: Identifiable, Codable, Hashable {
    var id: String
    var recordImage: String
    var recordText: String
}
