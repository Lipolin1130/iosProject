//
//  iosProjectApp.swift
//  iosProject
//
//  Created by funghi on 2022/6/5.
//

import SwiftUI
import Firebase
import GoogleSignIn
import FacebookCore
import FBSDKCoreKit

@main
struct iosProjectApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    init(){
        ApplicationDelegate.shared.application(UIApplication.shared)
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL{ url in
                    ApplicationDelegate.shared.application(UIApplication.shared, open: url, sourceApplication: nil, annotation: UIApplication.OpenURLOptionsKey.annotation)
                }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool{
        return true
    }
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any])
    -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}
