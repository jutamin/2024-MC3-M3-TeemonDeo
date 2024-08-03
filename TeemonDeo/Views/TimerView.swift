//
//  TimerView.swift
//  TeemonDeo
//
//  Created by Geunhye on 7/31/24.
//

import SwiftUI
import AVFoundation

struct TimerView: View {

    @ObservedObject var timerManager = TimerManager()
    //@EnvironmentObject var soundViewModel: SoundViewModel
    
    @StateObject var audioPlayerViewModel = AudioPlayerViewModel()
    
    @State var isFinished : Bool = false

    var startLottieView = LottieView(filename: "TimerStartLottie", loopMode: .loop)
    
    var stopLottieView = LottieView(filename: "TimerStopLottie", loopMode: .loop)
    
    var completeLottieView = LottieView(filename: "ChallengeCompleteLottie", loopMode: .loop)
        
    var body: some View {
        VStack{
            HStack{
                Spacer()
                // 음악 버튼
                Button (action: {
                    if audioPlayerViewModel.isPlaying {
                        audioPlayerViewModel.stop()
                    } else {
                        audioPlayerViewModel.playOrPause()
                    }
                }) {
                    Image(audioPlayerViewModel.isPlaying ? "soundPlay" : "soundStop")
                }
            }
            .padding(.horizontal, 20)
            //가이드
            VStack{
                if self.timerManager.timerMode == .running {
                    HStack{
                        GeometryReader { geometry in
                            HStack{
                                Spacer()
                                Image("guideBox")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width*0.9)
                                    .overlay(
                                        Text("뭐시기부터 버려보세요 우아아아아앙ㅇ")
                                            .font(.system(size: 24, weight: .semibold))
                                            .frame(width: geometry.size.width * 0.8)
                                            .padding(),
                                        alignment: .center
                                    )
                                Spacer()
                            }
                        }
                        .frame(height: 140)
                    }
                } else {
                    VStack{
                        Spacer()
                        Text("책상부터 비워보자")
                            .font(.system(size: 18))
                            .foregroundColor(.gray)
                            .padding(.bottom, 12)
                        Text("비움 챌린지를 시작하세요")
                            .font(.system(size: 24, weight: .semibold))
                        Spacer()
                    }
                    .frame(height: 140)
                }
            }
            .padding(.bottom, 20)
            //타이머
            ZStack {
                HStack{
                    Rectangle()
                        .frame(width: 58, height: 48)
                        .foregroundColor(.gray)
                        .overlay {
                            Text(secToMin(seconds: timerManager.secondsLeft))
                                .frame(width: 70)
                        }
                    Text(":")
                    Rectangle()
                        .frame(width: 58, height: 48)
                        .foregroundColor(.gray)
                        .overlay {
                            Text(secToSec(seconds: timerManager.secondsLeft))
                                .frame(width: 70)
                        }
                }
                .font(.system(size: 36, weight: .semibold))
            }
            .padding(.bottom, 70)
            //시작/종료 버튼
            Button ( action: {
                if self.timerManager.timerMode == .running {
                    self.timerManager.pause()
                    startLottieView.stop()
                    isFinished = true
                } else {
                    self.timerManager.start()
                    startLottieView.play()
                }
                audioPlayerViewModel.playOrPause()
            }) {
                Text(self.timerManager.timerMode == .running ? "종료하기" : "시작하기")
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .padding(12)
                    .padding(.horizontal, 20)
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                    )           .foregroundColor(.black)
            }
            //로티
            startLottieView
                .ignoresSafeArea(.all)
                .frame(width: 360)
        }
        .padding(.top, 30)
    }

}

#Preview {
    TimerView()
}
