//
//  SettingInfoView.swift
//  TeemonDeo
//
//  Created by 원주연 on 8/5/24.
//

import SwiftUI

struct SettingInfoView: View {
    @Binding var showSignInView: Bool
    @StateObject private var settingViewModel = SettingsViewModel()
    
    var body: some View {
        NavigationStack{
            VStack{
                // 로그아웃, 계정삭제 버튼
                List {
                    Text("개인정보처리방침")
                    Text("서비스 이용약관")
                    // 로그아웃 버튼
                    Button("로그아웃") {
                        Task {
                            do {
                                try settingViewModel.signOut()
                                showSignInView = true
                            } catch {
                                print(error)
                            }
                        }
                    }
                    // 계정삭제 버튼
                    Button(role: .destructive) {
                        Task {
                            do {
                                try await settingViewModel.deleteAccount()
                                showSignInView = true
                            } catch {
                                print(error)
                            }
                        }
                    } label: {
                        Text("회원탈퇴")
                    }
                }.listStyle(.plain)
                    .padding()
                .onAppear {
                    // 어떤 SSO로 로그인했는지 확인
                    Task {
                        await settingViewModel.loadChallengeUser2()
                    }
                }
            }.navigationBarTitle("설정", displayMode: .inline).font(.SuitTitle2)
        }/*.navigationBarTitle("설정", displayMode: .inline).font(.SuitTitle2)*/
    }
}

//#Preview {
//    SettingInfoView()
//}
