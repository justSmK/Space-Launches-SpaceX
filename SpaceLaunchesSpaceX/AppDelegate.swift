//
//  AppDelegate.swift
//  SpaceLaunchesSpaceX
//
//  Created by justSmK on 18.03.2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let rocketsViewController = RocketsViewController()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: rocketsViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        registerDepenencies()
        
        return true
    }
    
    private func registerDepenencies() {
        let settingsService: SettingsServiceProtocol = SettingsService()
        ServiceLocator.shared.register(service: settingsService)
        let coreDataStack: CoreDataStackProtocol = CoreDataStack()
        ServiceLocator.shared.register(service: coreDataStack)
    }
}

