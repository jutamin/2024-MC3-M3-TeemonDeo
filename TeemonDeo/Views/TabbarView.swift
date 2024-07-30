//
//  TabbarView.swift
//  TeemonDeo
//
//  Created by 원주연 on 7/29/24.
//

import SwiftUI

struct TabbarView: View {
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        TabView {
            NavigationStack {
                ContentView()
            }
            .tabItem {
                Image(systemName: "cart")
                Text("챌린지")
            }
            
            NavigationStack {
                ContentView()
            }
            .tabItem {
                Image(systemName: "star.fill")
                Text("공개처형")
            }
            
            NavigationStack {
                SettingsView(showSignInView: $showSignInView)
            }
            .tabItem {
                Image(systemName: "person")
                Text("관리")
            }
        }
    }
}

struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView(showSignInView: .constant(false))
    }
}
