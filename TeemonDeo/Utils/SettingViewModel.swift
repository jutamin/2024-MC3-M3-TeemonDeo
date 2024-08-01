//
//  SettingViewModel.swift
//  TeemonDeo
//
//  Created by 원주연 on 7/30/24.
//

import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    
    @Published var authProviders: [AuthProviderOption] = []
    @Published var authUser: AuthDataResultModel? = nil
    //추가
    @Published var challengeUser: ChallengeUser? = nil

    func loadAuthProviders() {
        if let providers = try? AuthenticationManager.shared.getProviders() {
            authProviders = providers
        }
    }
    
    func loadAuthUser() {
        // SSO 로그인 정보 가져오기
        self.authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
    }
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
    
    func deleteAccount() async throws {
        try await AuthenticationManager.shared.delete()
    }

    // Friebase에서 유저 정보 가져오기
    func loadChallnegeUser() {
        self.challengeUser = try? AuthenticationManager.shared.getChallnegeUser()
    }
}
