//
//  RootView.swift
//  TeemonDeo
//
//  Created by 원주연 on 7/30/24.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignInView: Bool = false
    @State private var showSplashView: Bool = true
    
    var body: some View {
        ZStack{
            if showSplashView {
                LottieView(filename: "Splash", loopMode: .loop)
                    .opacity(showSplashView ? 1 : 0)
                    .ignoresSafeArea(.all)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            withAnimation(.easeIn(duration: 0.3)) {
                                showSplashView = false
                            }
                        }
                    }
            } else {
                ZStack {
                    if !showSignInView {
                        TabbarView(showSignInView: $showSignInView)
                    }
                }
                .onAppear {
                    //currentUser를 받아옴
                    let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
                    
                    //authUser의 값이 nil이라면(=currentUser가 없다면) showSignInView를 true로 바꿔줌 -> SignIn 뷰 띄움
                    self.showSignInView = authUser == nil
                }
                .fullScreenCover(isPresented: $showSignInView) {
                    NavigationStack {
                        LoginView(showSignInView: $showSignInView)
                    }
                }
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
