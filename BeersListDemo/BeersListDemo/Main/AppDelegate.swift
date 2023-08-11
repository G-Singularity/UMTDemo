//
//  AppDelegate.swift
//  BeersListDemo
//
//  Created by dqh on 8/8/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        monitorNetwork()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - 实时网络监测
    func monitorNetwork() {
        ReachabilityTool.monitorNetworkStatus1 { status in
            var message = ""
            switch status {
            case .unknown:
                message = "未知网络"
            case .notReachable:
                message = "无网络连接"
                Alert.show(type: .error, text: message)
            case .wwan:
                message = "蜂窝移动网络"
            case .ethernetOrWiFi:
                message = "WiFi"
            }
            //Alert.show(type: .info, text: message) 只有无网络时才提示
        }
    }
}

