//
//  TabbarView.swift
//  TeemonDeo
//
//  Created by 원주연 on 7/30/24.
//

import SwiftUI

struct TabbarView: View {
    
    @Binding var showSignInView: Bool
    @Binding var showOnboardingView: Bool
    
    var body: some View {
        TabView {
            NavigationStack {
                ContentView()
                PieChartView(data: iPhoneOperationSystem.dummyData())
            }
            .tabItem {
                Image(systemName: "cart")
                Text("Products")
            }
            
            NavigationStack {
                ChallengeMainView()
            }
            .tabItem {
                Image(systemName: "star.fill")
                Text("Favorites")
            }
            
            NavigationStack {
                SettingView(showSignInView: $showSignInView)
            }
            .tabItem {
                Image(systemName: "person")
                Text("Profile")
            }
        }
    }
}

struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView(showSignInView: .constant(false), showOnboardingView: .constant(false))
    }
}
