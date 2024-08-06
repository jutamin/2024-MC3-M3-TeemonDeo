//
//  OnboardingView.swift
//  TeemonDeo
//
//  Created by 원주연 on 8/3/24.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var settingViewModel = SettingsViewModel()
    @State private var userNickname: String = ""
    @Binding var showSignInView: Bool
    @Binding var showOnboardingView: Bool
    
    var body: some View {
        VStack{
            HStack{
                Text("복세단살")
                    .font(Font.laundryBold20)
                Spacer()
            }
            
            HStack{
                VStack(alignment: .leading) {
                    Text("안녕하세요!\n이름을 알려주세요!")
                        .font(.SuitTitle1)
                        .padding(.bottom)
                    
                    Text("*닉네임은 이후 [관리]페이지에서\n  수정이 가능합니다.")
                        .foregroundStyle(Color.gray400)
                        .font(.SuitArlert1)
                }
                .padding()
                
                Spacer()
                
                Image("mainviewcharactor")
                    .resizable()
                    .frame(maxWidth: 132, maxHeight: 140)
            }
            .padding(.vertical)
            

            ZStack(alignment: .trailing) {
                TextField("닉네임을 입력해주세요", text: $userNickname)
                    .font(.SuitTitle2)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray100))
                    .onChange(of: userNickname) { newValue in
                        if newValue.count > 10 {
                            userNickname = String(newValue.prefix(10))
                        }
                    }
                    .padding(.horizontal)
                
                Text("\(userNickname.count)/10자")
                    .font(.SuitBody2)
                    .foregroundColor(.gray400)
                    .padding(.trailing, 35)
            }
            
            Spacer()
            
            Button(action:{
                if userNickname.isEmpty {
                    print("Complete Input and sign in...")
                } else {
                    print("닉네임 설정 전: \(settingViewModel.challengeUser?.userNickname as Any)")
                    Task {
                        await settingViewModel.updateChallengeUserNickname(nickname: userNickname)
                        print("닉네임 설정 후: \(settingViewModel.challengeUser?.userNickname as Any)")
                    }
                    showOnboardingView = false
                    showSignInView = false
                }
            },
                   label: {
                Text("완료")
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background{
                        Rectangle()
                            .foregroundStyle(userNickname.isEmpty ? Color.gray200 : Color.black)
                    }
            })
        }
        .padding()
        .onAppear() {
            settingViewModel.loadChallnegeUser()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    OnboardingView(showSignInView: .constant(false), showOnboardingView: .constant(false))
}
