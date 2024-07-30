//
//  RootView.swift
//  TeemonDeo
//
//  Created by 원주연 on 7/29/24.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignInView: Bool = false
    
    var body: some View {
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

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
