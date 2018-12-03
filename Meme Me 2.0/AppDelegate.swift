//
//  AppDelegate.swift
//  Meme Me 2.0
//
//  Created by Mohammed ALZAHRANI on 11/28/18.
//  Copyright © 2018 Mohammed ALZAHRANI. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var memes = [Meme]()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    // Delete a meme
    func deleteMeme(index: Int){
        memes.remove(at: index)
    }

}

