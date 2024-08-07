//
//  TimerView.swift
//  TeemonDeo
//
//  Created by Geunhye on 7/31/24.
//

import SwiftUI
import AVFoundation

struct TimerView: View {

    @ObservedObject var timerViewModel = TimerViewModel()

    
    @Binding var path: NavigationPath

    var timerChalData: TimerData

    @State private var isActive = false
    
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
                            HStack(alignment: .center){
                                Spacer()
                                Image("guideBox")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width*0.9)
                                    .overlay(
                                        Text("\(timerViewModel.randomSentence)")
                                            .font(.PretendardSemiBold24)
                                            .frame(width: geometry.size.width * 0.8)
                                            .padding()
                                            .multilineTextAlignment(.center),
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
                        Text("\(timerChalData.challenge.challengeName)")
                            .font(.SuitTitle3)
                            .foregroundColor(.gray400)
                            .padding(.bottom, 12)
                        Text("비움 챌린지를 시작하세요")
                            .font(.SuitTitle1)
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
                        .foregroundColor(.gray100)
                        .overlay {
                            Text(secToMin(seconds: timerManager.secondsLeft))
                                .frame(width: 70)
                        }
                    Text(":")
                    Rectangle()
                        .frame(width: 58, height: 48)
                        .foregroundColor(.gray100)
                        .overlay {
                            Text(secToSec(seconds: timerManager.secondsLeft))
                                .frame(width: 70)
                        }
                }
                .font(.SuitTimer)
            }
            .padding(.bottom, 70)
            
            
            Button ( action: {
                if self.timerManager.timerMode == .running {
                    self.timerManager.pause()
                    startLottieView.stop()
                    isFinished = true
                    isActive = true
                    //path.append("CertifyingView")
                    path.append(CertifyingData(challenge: timerChalData.challenge))

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
            
            // TODO: 다른 버전의 NavigationLink로 변경


            //로티
            startLottieView
                .ignoresSafeArea(.all)
                .frame(width: 360)
        }
        .onAppear{
            timerViewModel.getRandomSentence(category: timerChalData.challenge.challengeSpace)
        }
        .padding(.top, 30)
        .navigationBarBackButtonHidden()

    }

}

struct Category: Identifiable {
    let id = UUID()
    let name: String
    let sentences: [String]
}

