//
//  ContentView.swift
//  TeemonDeo
//
//  Created by TEO on 7/23/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = SettingsViewModel()
    var body: some View {
        VStack {
            Text("유저 uid : \(viewModel.challengeUser?.userId ?? "혹시나 에러 났을 때를 대비한 디폴트 값")")
            Text("유저 email : \(viewModel.challengeUser?.userEmail ?? "혹시나 에러 났을 때를 대비한 디폴트 값")")
            Text("유저 닉네임 : \(viewModel.challengeUser?.userNickname ?? "혹시나 에러 났을 때를 대비한 디폴트 값")")
            Text("유저 uid : \(viewModel.challengeUser?.userTier ?? 111)") //유저 못 불러오면 111로 뜸
        }
        .onAppear(){
            viewModel.loadChallnegeUser()

            for family: String in UIFont.familyNames {
                            print(family)
                            for names : String in UIFont.fontNames(forFamilyName: family){
                                print("=== \(names)")
                            }
                        }
        }

        
//        LottieView(filename: "Splash")
//            .ignoresSafeArea(.all)
//        Text("hello")
        
    }
    
}

#Preview {
    ContentView()
}
