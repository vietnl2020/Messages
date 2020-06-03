//
//  AppDelegate.swift
//  MessageKit
//
//  Created by Nguyen Viet on 5/25/20.
//  Copyright © 2020 Nguyen Viet. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        //let db = Firestore.firestore()
        return true
    }

}

