//
//  AppDelegate.swift
//  ForceTouch
//
//  Created by ShinokiRyosei on 2016/03/05.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    enum ShortcutIdentifier: String{
        case First
        case Second
        case Third
        case Forth
        
        
        init?(fullType: String) {
            guard let last = fullType.componentsSeparatedByString(".").last else {
                return nil
            }
            
            self.init(rawValue: last)
            
        }
        
        var type: String {
            return NSBundle.mainBundle().bundleIdentifier! + ".\(self.rawValue)"
        }
        
    }
    
    static let applicationShortcutInfoIconKey = "applicationShortcutInfoIconKey"
    
    var window: UIWindow?
    
    var launchedShortcutItem: UIApplicationShortcutItem?
    
    func handleShortcutItem(shortcutItem: UIApplicationShortcutItem) -> Bool {
        var handled = false
        
        guard ShortcutIdentifier(fullType: shortcutItem.type) != nil else {
            return false
        }
        
        guard let shortCutType = shortcutItem.type as String? else {
            return false
        }
        
        switch (shortCutType) {
        case ShortcutIdentifier.First.type:
           handled = true
            break
        case ShortcutIdentifier.Second.type:
            handled = true
            break
        case ShortcutIdentifier.Third.type:
            handled = true
            break
        case ShortcutIdentifier.Forth.type:
            handled = true
            break
        default:
            break
        }
        
        let alertController = UIAlertController(title: "ShortCutHandler", message: "\"\(shortcutItem.localizedTitle)\"", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(okAction)
        
        let playVC = PlayViewController()
        
        if shortcutItem.type == ShortcutIdentifier.First.type {
//            window!.rootViewController?.presentViewController(playVC, animated: true, completion: nil)
            if let tabController = self.window?.rootViewController as? UITabBarController {
//                window?.rootViewController?.presentViewController(, animated: true, completion: nil)
//                tabController.performSegueWithIdentifier("", sender: nil)
                tabController.selectedIndex = 2
            }
            
        }else {
            window!.rootViewController?.presentViewController(alertController, animated: true, completion: nil)
        }
        
        
        
        
        
        return handled
    }
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        var shouldPerformAdditionalDeledating = true
        
        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsShortcutItemKey] as? UIApplicationShortcutItem {
            launchedShortcutItem = shortcutItem
            shouldPerformAdditionalDeledating = false
        }
        
        if let shortcutItem = application.shortcutItems where shortcutItem.isEmpty {
            
            let shortcut3 = UIMutableApplicationShortcutItem(type: ShortcutIdentifier.Third.type, localizedTitle: "Play", localizedSubtitle: "Will Play an Item", icon: UIApplicationShortcutIcon(type: .Play), userInfo: [AppDelegate.applicationShortcutInfoIconKey: UIApplicationShortcutIconType.Play.rawValue])
            
            let shortcut4 = UIMutableApplicationShortcutItem(type: ShortcutIdentifier.Forth.type, localizedTitle: "Pause", localizedSubtitle: "Will Pause an Item", icon: UIApplicationShortcutIcon(type: .Pause), userInfo: [AppDelegate.applicationShortcutInfoIconKey: UIApplicationShortcutIconType.Pause.rawValue])
            
            application.shortcutItems = [shortcut3, shortcut4]
        }

        return shouldPerformAdditionalDeledating
    }
    
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        let handledShortcutItem = handleShortcutItem(shortcutItem)
        
        completionHandler(handledShortcutItem)
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
        guard let shortCut = launchedShortcutItem else {
            return
        }
        
        handleShortcutItem(shortCut)
        
        launchedShortcutItem = nil
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

