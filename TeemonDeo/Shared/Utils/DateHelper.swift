//
//  ChallengeDetailViewModel.swift
//  TeemonDeo
//
//  Created by 김민정 on 7/31/24.
//


import Foundation


struct DateHelper {
    
    // 날짜 형식 설정
    private static let dateFormat = "yyyy.MM.dd"
    
    // 날짜를 yy년 mm월 dd일 로 출력하는 함수
    static func translateDate() -> String {
        let today = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yy년 MM월 dd일"
        return formatter.string(from: today)
    }
    
    // 종료 날짜를 계산하는 함수
    static func calculateEndDate(startDate: String, period: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat

        guard let start = dateFormatter.date(from: startDate) else {
            return "잘못된 날짜"
        }

        guard let endDate = Calendar.current.date(byAdding: .day, value: period*7, to: start) else {
            return "날짜 계산 오류"
        }

        return dateFormatter.string(from: endDate)
    }

    
    // 현재 도전일을 계산하는 함수
    static func calculateCurrentDay(startDate: String) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat

        guard let start = dateFormatter.date(from: startDate) else {
            return 0
        }

        let currentDate = Date()
        let components = Calendar.current.dateComponents([.day], from: start, to: currentDate)

        return max(0, components.day ?? 0)
    }
    

    // 진행도를 계산하는 함수
    static func calculateProgress(startDate: String, period: Int) -> Int {
        let currentDay = calculateCurrentDay(startDate: startDate)
        let progress = Double(currentDay) / Double(period*7) * 100
        if progress >= 100 {
            return 100
        } else{
            return Int(progress)
        }
    }
    
}
