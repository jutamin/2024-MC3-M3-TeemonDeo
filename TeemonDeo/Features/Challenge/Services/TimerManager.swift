//
//  TimerManager.swift
//  TimerPractice
//
//  Created by Geunhye on 7/31/24.
//

import SwiftUI
import Foundation

class TimerManager: ObservableObject {
    @Published var timerMode: TimerMode = .initial
    
    @Published var secondsLeft = 600
    
    var timer = Timer()
    
    func start() {
        timerMode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            if self.secondsLeft == 0 {
//                self.timerMode = .initial
//                self.secondsLeft = 60
//                timer.invalidate()
                self.reset()
            }
            self.secondsLeft -= 1
        })
    }
    
    func reset() {
        self.timerMode = .initial
        self.secondsLeft = 600
        timer.invalidate()
    }
    
    func pause() {
        self.timerMode = .paused
        timer.invalidate()
    }
}
