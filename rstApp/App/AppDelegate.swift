//
//  AppDelegate.swift
//  rstApp
//
//  Created by Grigory Stolyarov on 10.05.2023.
//

import SwiftUI
import SDWebImageSwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        SDImageCache.shared.config.maxDiskAge = 1_209_600 // 14 days = 60 * 60 * 24 * 14
        SDImageCache.shared.config.maxDiskSize = 52_428_800 // 50 MB = 10 * 1024 * 1024
        
        return true
    }
}
