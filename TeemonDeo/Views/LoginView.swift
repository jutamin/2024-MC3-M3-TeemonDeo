//
//  LoginView.swift
//  TeemonDeo
//
//  Created by 원주연 on 7/29/24.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

@MainActor
final class AuthenticationViewModel: ObservableObject {
        
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn() // 구글 로그인 과정 (비동기로 진행)
        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens) // 구글 로그인 토큰 값으로 firebase에 user 정보 저장
    }
    
    func signInApple() async throws {
        let helper = SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow() // 애플 로그인 과정 (비동기로 진행)
        try await AuthenticationManager.shared.signInWithApple(tokens: tokens) // 애플 로그인 토큰 값으로 firebase에 user 정보 저장
    }
}

struct LoginView: View {
    
    @StateObject private var viewModel = AuthenticationViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        ZStack{
            Image("LoginViewBG")
                .resizable()
                .ignoresSafeArea(.all)
            VStack {
//                Text("로그인하기")
                Spacer()
                
                // Sign in with Google 버튼
                GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
                    Task {
                        do {
                            try await viewModel.signInGoogle() //signInGoogle 과정 시작 (비동기로 진행)
                            showSignInView = false //signInGoogle 과정 끝나면 AuthenticationView 종료
                        } catch {
                            print(error)
                        }
                    }
                }
                
                // Sign in with Apple 버튼
                Button(action: {
                    Task {
                        do {
                            try await viewModel.signInApple() //signInApple 과정 시작 (비동기로 진행)
                            showSignInView = false //signInApple 과정 끝나면 AuthenticationView 종료
                        } catch {
                            print(error)
                        }
                    }
                }, label: {
                    SignInWithAppleButtonViewRepresentable(type: .default, style: .black)
                        .allowsHitTesting(false)
                })
                .frame(height: 55)
                
                Spacer().frame(maxHeight: 80)
            }
            .padding()
//            .navigationTitle("Sign In")
        }
    }
}

//#Preview {
//    AuthenticationView()
//}
