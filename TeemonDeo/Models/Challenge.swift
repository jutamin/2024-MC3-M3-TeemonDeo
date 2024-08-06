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

struct TimerData: Hashable {
    let challenge: Challenge
    // 타이머에 필요한 추가 데이터
}

struct CertifyingData: Hashable {
    let challenge: Challenge
    // 인증에 필요한 추가 데이터
}

struct CertifyingFinishedData: Hashable {
    let challenge: Challenge
    // 인증 완료에 필요한 추가 데이터
}
