//
//  rstAppApp.swift
//  rstApp
//
//  Created by Grigory Stolyarov on 10.05.2023.
//

import SwiftUI

@main
struct rstAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
