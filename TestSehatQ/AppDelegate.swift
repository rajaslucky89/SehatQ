//
//  AppDelegate.swift
//  TestSehatQ
//
//  Created by Raja on 08/08/19.
//  Copyright © 2019 Raja. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import RealmSwift
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //  Realm Configuration
        RealmConfiguration.config()
        
        setRoutes()
        IQKeyboardManager.shared.enable = true
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        GIDSignIn.sharedInstance().clientID = Constants.GOOGLE_CLIENT_ID
        FirebaseApp.configure()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    func application(_ application:UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        let facebookHandle = FBSDKApplicationDelegate.sharedInstance().application(application, open: url, options: options)
        let googleHandle = GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        return facebookHandle || googleHandle
    }
}

extension AppDelegate {
    private func setRoutes() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let routes = Routes(window: window!)
        let viewController = LoginViewController()
        routes.setAppRootViewController(with: viewController)
        window?.makeKeyAndVisible()
    }
}
