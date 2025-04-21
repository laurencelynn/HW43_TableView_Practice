//
//  SceneDelegate.swift
//  HW43_TableView_Practice
//
//  Created by 林上閔 on 4/19/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        
        // 使用自訂的 SettingsViewController（也就是 inset grouped style）
        let settingsVC = SettingsViewController(style: .insetGrouped)
        
        // 把 settingsVC 包裝在 Navigation Controller 裡，並設成 rootViewController
        let navController = UINavigationController(rootViewController: settingsVC)
        
        window.rootViewController = navController
        self.window = window
        window.makeKeyAndVisible()
    }

    
}

