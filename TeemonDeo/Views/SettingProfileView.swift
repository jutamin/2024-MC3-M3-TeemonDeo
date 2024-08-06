//
//  SettingProfileView.swift
//  TeemonDeo
//
//  Created by 김민정 on 8/2/24.
//

import SwiftUI

struct SettingProfileView: View {
    @State private var nickname: String = ""
    @StateObject private var settingViewModel = SettingsViewModel()
    
    var body: some View {
        VStack {
            Button(action: {},
                   label: {
                Image("defaultProfileImage")
                    .resizable()
                    .frame(maxWidth: 80, maxHeight: 80)
            })
            .padding(14)
            
            VStack(alignment: .leading) {
                Text("닉네임")
                    .font(.SuitTitle3)
                    .padding()
                    .padding(.bottom, -10)
                
                ZStack(alignment: .trailing) {
                    TextField("닉네임을 입력해주세요", text: $nickname)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray100))
                        .onChange(of: nickname) { newValue in
                            if newValue.count > 10 {
                                nickname = String(newValue.prefix(10))
                            }
                        }
                        .padding(.horizontal)
                    
                    Text("\(nickname.count)/10자")
                        .font(.SuitBody2)
                        .foregroundColor(.gray400)
                        .padding(.trailing, 35)
                }
                .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            Spacer()
            
            Button(action: {
                // 버튼 클릭 시 실행될 코드
                if nickname.isEmpty {
                    print("Complete Input and sign in...")
                } else {
                    print("닉네임 설정 전: \(settingViewModel.challengeUser?.userNickname as Any)")
                    Task {
                        await settingViewModel.updateChallengeUserNickname(nickname: nickname)
                        print("닉네임 설정 후: \(settingViewModel.challengeUser?.userNickname as Any)")
                    }
                }
            }) {
                Text("저장")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 65)
                    .background(nickname.isEmpty ? Color.gray200 : Color.black)
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, -20)
            .padding(.leading, -20)
            .padding(.trailing, -20)
            .disabled(nickname.isEmpty)
        }
        .padding()
        .navigationBarTitle("프로필 수정")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SettingProfileView_Previews: PreviewProvider {
    static var previews: some View {
        SettingProfileView()
    }
}

