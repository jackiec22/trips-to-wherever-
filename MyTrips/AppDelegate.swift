//
//  AppDelegate.swift
//  MyTrips
//
//  Created by Jackie Chang on 1/6/16.
//  Copyright © 2016 Jackie Chang. All rights reserved.
//

import UIKit

let purpleThemeColor = UIColor(red: 91.0/255.0, green: 77.0/255.0, blue: 137.0/255.0, alpha: 1.0)
let greenThemeColor = UIColor(red: 51.0/255.0, green: 228.0/255.0, blue: 197.0/255.0, alpha: 1.0) //Hex code: #33E4C5
let yellowThemeColor = UIColor(red: 249.0/255.0, green: 232.0/255.0, blue: 81.0/255.0, alpha: 1.0)
let pinkThemeColor = UIColor(red: 254.0/255.0, green: 29.0/255.0, blue: 197.0/255.0, alpha: 1.0)

let titleThemeColor = UIColor.whiteColor()
let selectedThemeColor = pinkThemeColor
let backThemeColor = UIColor.whiteColor()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // set the colors for the application appearance
        // the time & Battery line set to white - also needs change in plist to "NO"
        application.statusBarStyle = UIStatusBarStyle.LightContent // also need change in info.plist
        
        // Navigation Bar appearance
        let navAppear = UINavigationBar.appearance()
        navAppear.barStyle = UIBarStyle.Black
        navAppear.barTintColor = purpleThemeColor
        navAppear.tintColor = backThemeColor   // "Back" color
        navAppear.titleTextAttributes = [NSForegroundColorAttributeName: titleThemeColor  ] // color for the title
        
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

