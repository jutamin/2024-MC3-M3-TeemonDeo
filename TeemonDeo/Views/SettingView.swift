//
//  SettingView.swift
//  TeemonDeo
//
//  Created by 원주연 on 7/30/24.
//

import SwiftUI

struct SettingView: View {
    
    @Binding var showSignInView: Bool
    @StateObject private var settingViewModel = SettingsViewModel()
    @StateObject private var mainViewModel = ChallengeMainViewModel()
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Text("관리")
                        .font(Font.laundryBold20)
                    
                    Spacer()
                    
                    Image(systemName: "gearshape")
                }
                .padding()
                
                Spacer()
                
                profileView()
                    .padding(8)
                
                endedChallengeListView()
                    .background(Color.gray100)
                
                // 로그아웃, 계정삭제 버튼
                List {
                    // 로그아웃 버튼
                    Button("Log out") {
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
                        Text("Delete account")
                    }
                }
                .onAppear {
                    // 어떤 SSO로 로그인했는지 확인
                    settingViewModel.loadAuthProviders()
                }
            }
        }
    }
}

struct profileView: View {
    @StateObject private var settingViewModel = SettingsViewModel()
    
    var body: some View {
        
        VStack() {
            Button(action: {},
                   label: {
                Image("defaultProfileImage")
                    .resizable()
                    .frame(maxWidth: 80, maxHeight: 80)
            })
            .padding(.bottom, 14)
            
                Text(settingViewModel.challengeUser?.userNickname ?? "유저닉네임")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
            
            (Text(Image(systemName: "seal.fill")) + Text(" 개쩌는 티어: \(settingViewModel.challengeUser?.userTier ?? 111)"))
                    .font(.footnote)
                    .foregroundStyle(Color.gray800)
        }
        .padding(.horizontal)
        .onAppear(){
            settingViewModel.loadChallnegeUser()
        }
    }
}

struct endedChallengeListView: View {
    @StateObject var mainViewModel = ChallengeMainViewModel()

    var body: some View {
        VStack{
            HStack{
                Text("지난 챌린지")
                    .font(.laundryBold20)
                    .fontWeight(.bold)
                Spacer()
                
                Text(String(mainViewModel.challengesCount))
                
                RoundedRectangle(cornerRadius: 2)
                    .frame(width: 10, height: 10)
                    .foregroundStyle(Color.mainBlue)
                
                Text("3 완료")
                    .font(.callout)
                    .foregroundStyle(Color.mainBlue)
                
                RoundedRectangle(cornerRadius: 2)
                    .frame(width: 10, height: 10)
                    .foregroundStyle(Color.gray400)
                Text("4 미완료")
                    .font(.callout)
                    .foregroundStyle(Color.gray400)
                
            }
            .padding(.top, 28)
            .padding(.horizontal,20)
            
            ForEach(mainViewModel.challenges) { chall in
                NavigationLink(value: chall) {
                    endedChallengeListCell(challenge: chall)
                        .padding(.horizontal)
                        .background{
                            RoundedRectangle(cornerRadius: 20.0)
                                .foregroundStyle(.white)
                        }
                }
            }
        }
//        .onAppear(){
//            mainViewModel.countChallenge(challenge: )
//        }
    }
}

struct endedChallengeListCell: View {
    var challenge: Challenge
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 8) {
                Text("책상부터 비워보자")
                Text(challenge.challengeName)
                    .font(.headline)
                    .fontWeight(.semibold)
                Text(challenge.challengeStartDate)
                Text("2024.07.24 ~ 2024.07.31")
                    .font(.caption)
                    .foregroundStyle(.gray)
                HStack{
                    Text("1주 챌린지")
                        .font(.caption)
                        .foregroundStyle(.blue)
                        .padding(3)
                        .background{
                            RoundedRectangle(cornerRadius: 6)
                                .foregroundStyle(.blue).opacity(0.2)
                        }
                    Text("책상")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .padding(3)
                        .background{
                            RoundedRectangle(cornerRadius: 6)
                                .foregroundStyle(.gray).opacity(0.2)
                        }
                }
            }
            .padding()
            
            Spacer()
            
            Image("challengeCompleted")
                .resizable()
                .frame(maxWidth: 70, maxHeight: 70)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingView(showSignInView: .constant(false))
        }
    }
}
