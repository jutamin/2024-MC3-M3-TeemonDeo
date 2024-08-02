//
//  Challenge.swift
//  TeemonDeo
//
//  Created by 김민정 on 7/31/24.
//

import Foundation

struct Challenge: Hashable {
    let id: String
    let challengeName: String
    let challengeStartDate: String
    let challengePeriod: Int
    let challengeSpace: String
    let isChallengeSucceed: Bool
}
