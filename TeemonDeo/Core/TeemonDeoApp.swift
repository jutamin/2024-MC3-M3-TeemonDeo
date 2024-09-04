//
//  TeemonDeoApp.swift
//  TeemonDeo
//
//  Created by TEO on 7/23/24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct TeemonDeoApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            //NavigationView {
                RootView()
                .environmentObject(TimerViewModel())

                //TimerView()
           // }
        }
    }
}
