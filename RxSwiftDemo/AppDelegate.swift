//
//  AppDelegate.swift
//  RxSwiftDemo
//
//  Created by wuna on 2021/9/10.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window?.rootViewController = UINavigationController.init(rootViewController: ViewController.init())
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        
        return true
    }

}


public func example(of description:String, action:()->Void) {
    print("\n --- Example of:", description, "---")
    action()
}
