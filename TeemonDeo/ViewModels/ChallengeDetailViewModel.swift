//
//  ChallengeDetailViewModel.swift
//  TeemonDeo
//
//  Created by TEO on 8/6/24.
//


import Foundation
import SwiftUI

class ChallengeDetailViewModel: ObservableObject {
    @Published var recordCount: Int = 0
    //@Published var challengPeriod: Int = 0
//    var progressPercent: Int = {
//        return Int(Double(self.recordCount) / Double(self.challengPeriod * 7) * 100)
//    }
    
    var challengeId: String = ""
    var records: [ChallengeRecord] = []
    
    let fireStoreChallengeManager = FireStoreChallengeManager()
    let fireStoreRecordManager = FireStoreRecordManager()
    
    
    func loadRecords(challengeId: String) async {
        do{
            self.records = try await fireStoreRecordManager.fetchRecords(challengeId: challengeId)
            DispatchQueue.main.async {
                self.recordCount = self.records.count
            }
        } catch {
            print("loadRecords ERROR")
        }
    }
}
