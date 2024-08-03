//
//  Challenge.swift
//  TeemonDeo
//
//  Created by TEO on 8/2/24.
//

import Foundation

struct Challenge : Identifiable, Hashable {
    let id: String
    let challengeName: String
    let challengeStartDate: String
    let challengePeriod: Int
    let challengeSpace: String
    let isChallengeSucceed: Bool
}
