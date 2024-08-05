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
        NavigationStack{
            TabView {
                VStack {
                    ContentView()
                    PieChartView(data: iPhoneOperationSystem.dummyData())
                }
                .tag(0)
                .tabItem {
                    Image(systemName: "cart")
                    Text("Products")
                }
                
                ChallengeMainView()
                    .tag(1)
                    .tabItem {
                        Image(systemName: "star.fill")
                        Text("Favorites")
                    }
                
                SettingView(showSignInView: $showSignInView)
                    .tag(2)
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                    }
            }
        }
    }
}

struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView(showSignInView: .constant(false), showOnboardingView: .constant(false))
    }
}
