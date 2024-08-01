//
//  AuthenticationManager.swift
//  TeemonDeo
//
//  Created by 원주연 on 7/30/24.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    let isAnonymous: Bool
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
        self.isAnonymous = user.isAnonymous
    }
}

// 사용자가 어떤 provider로 로그인했는지 구분 (Google or Apple)
enum AuthProviderOption: String {
    case google = "google.com"
    case apple = "apple.com"
}

final class AuthenticationManager {
    static let shared = AuthenticationManager()
    private init() { }
    
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        //currentUser를 user 변수에 저장
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        //user 변수를 AuthDataResultModel에 맞게 retrun
        return AuthDataResultModel(user: user)
    }
    
    func getProviders() throws -> [AuthProviderOption] {
        guard let providerData = Auth.auth().currentUser?.providerData else {
            throw URLError(.badServerResponse)
        }
        
        var providers: [AuthProviderOption] = []
        for provider in providerData {
            if let option = AuthProviderOption(rawValue: provider.providerID) {
                providers.append(option)
            } else {
                assertionFailure("Provider option not found: \(provider.providerID)")
            }
        }
        print(providers)
        return providers
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func delete() async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badURL)
        }
        try await user.delete()
    }
}

// MARK: SIGN IN SSO (SSO: Sigle Sign On)
extension AuthenticationManager {
    
    @discardableResult
    // 구글로그인으로 받아온 idToken, accessToken 값을 파이어베이스 AuthDataResultModel에 맞추어 SignIn 함수에게 전달
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken,
                                                       accessToken: tokens.accessToken)
        return try await signIn(credential: credential)
    }
    
    @discardableResult
    // 애플로그인으로 받아온 idToken, rawNonce 값을 파이어베이스 AuthDataResultModel에 맞추어 SignIn 함수에게 전달
    func signInWithApple(tokens: SignInWithAppleResult) async throws -> AuthDataResultModel {
        let credential = OAuthProvider.credential(withProviderID: AuthProviderOption.apple.rawValue, idToken: tokens.token, rawNonce: tokens.nonce)
        return try await signIn(credential: credential)
    }
    
    func signIn(credential: AuthCredential) async throws -> AuthDataResultModel {
        // credential로 받은 값으로 firebase auth에 유저 저장.
        let authDataResult = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: authDataResult.user)
    }
}

