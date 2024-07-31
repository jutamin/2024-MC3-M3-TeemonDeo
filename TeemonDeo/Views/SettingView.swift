//
//  SettingViews.swift
//  TeemonDeo
//
//  Created by 원주연 on 7/30/24.
//

import SwiftUI

struct SettingView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        ZStack{
            Color(.secondarySystemBackground)
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                profileView()
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    .background{
                        RoundedRectangle(cornerRadius: 20.0)
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal)
                
                
                HStack{
                    Text("지난 챌린지")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                    
                    RoundedRectangle(cornerRadius: 2)
                        .frame(width: 10, height: 10)
                        .foregroundStyle(.blue)
                    Text("3 완료")
                        .font(.callout)
                    
                    RoundedRectangle(cornerRadius: 2)
                        .frame(width: 10, height: 10)
                        .foregroundStyle(.gray)
                    Text("4 미완료")
                        .font(.callout)
                    
                }
                .padding(.top)
                .padding(.horizontal,24)
                
                endedChallengeListView()
                    .frame(maxWidth: .infinity)
                    .background{
                        RoundedRectangle(cornerRadius: 20.0)
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal)
                
                
                List {
                    // 로그아웃 버튼
                    Button("Log out") {
                        Task {
                            do {
                                try viewModel.signOut()
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
                                try await viewModel.deleteAccount()
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
                    viewModel.loadAuthProviders()
                    viewModel.loadAuthUser()
                }
            }
            .navigationBarItems(leading: Text("관리").font(.title).fontWeight(.bold))
            .navigationBarItems(trailing: Image(systemName: "gearshape"))
        }
    }
}

struct profileView: View {
    var body: some View {
        HStack(spacing: 10) {
            Image("defaultProfileImage")
                .resizable()
                .frame(maxWidth: 60, maxHeight: 60)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("누구길래티몬데오")
                    .font(.headline)
                    .fontWeight(.bold)
                Text("🎖️ 개쩌는 티어")
                    .font(.footnote)
                    .foregroundStyle(.blue)
            }
            .padding()
            
            Spacer()
            
            Button(action: {},
                   label: {
                (Text("수정") + Text(Image(systemName: "pencil")))
                    .font(.footnote)
                    .padding(5)
                    .foregroundStyle(.gray)
                    .background{
                        RoundedRectangle(cornerRadius: 6.0)
                            .stroke(.gray)
                            .foregroundStyle(.clear)
                    }
            })
            .padding(.bottom, 30)
        }.padding(.horizontal)
    }
}

struct endedChallengeListView: View {
    var body: some View {
        VStack{
            endedChallengeListCell()
                .padding(.horizontal)
                .background{
                    RoundedRectangle(cornerRadius: 20.0)
                        .foregroundStyle(.white)
                }
        }
    }
}

struct endedChallengeListCell: View {
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 8) {
                Text("책상부터 비워보자")
                    .font(.headline)
                    .fontWeight(.semibold)
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
            //                .padding()
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
