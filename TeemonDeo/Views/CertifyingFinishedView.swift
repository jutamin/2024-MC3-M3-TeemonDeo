//
//  SwiftUIView.swift
//  TeemonDeo
//
//  Created by TEO on 8/5/24.
//

import SwiftUI

struct CertifyingFinishedView: View {
    @Binding var path: NavigationPath
    var certFinlData: CertifyingFinishedData

    @StateObject var mainViewModel = ChallengeMainViewModel()
    var challengeData: Challenge
    
    var body: some View {
        VStack{

            VStack{
                Text(DateHelper.translateDate())
                    .font(.SuitBody2)
                    .foregroundColor(.gray400)
                    .padding(.bottom, 10)
                
                // 오늘의 문구 출력
                Text("책상부터 비워보자")
                    .font(.SuitTitle3)
                    .foregroundColor(.gray800)
            }
            .padding()
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 200)
                    .fill(Color.gray100)
            )
            .padding(.top, 50)

            
            
            Text("오늘의 비움 완료!")
                .font(.SuitHeadline)
                .padding(.top, 20)
            
            Spacer()
            
            Image("CertifyingFinished")
                .resizable()
                .frame(width: 215, height: 261)
            
            Spacer()

            Button {
                path.removeLast(path.count)
                mainViewModel.countCompletedChallenge(challenge: challengeData)
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.black)
                        .frame(maxWidth: .infinity, maxHeight: 59)
                    
                    Text("확인")
                        .font(.SuitTitle2)
                        .foregroundColor(.white)
                }
            }
            .padding()
            .padding(.horizontal)

            
        }
        .navigationBarBackButtonHidden()
    }
}
