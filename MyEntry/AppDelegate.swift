//
//  AppDelegate.swift
//  MyEntry
//
//  Created by panchal kinjal  on 06/09/21.
//

import UIKit
import IQKeyboardManagerSwift
import SideMenuSwift
import GooglePlaces
import GoogleSignIn
import Stripe
import FBSDKCoreKit

 
let signInConfig = GIDConfiguration.init(clientID: googleSigninKey)

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        GMSPlacesClient.provideAPIKey(GoogleMapApiKey)
        IQKeyboardManager.shared.enable = true
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().backgroundColor = .clear
        
        STPAPIClient.shared.publishableKey = "pk_test_51KBjHoCFvjCP6HVsdGLkjf0SJYm8Q8aYhQqhAC1GPy6o9lWGbZGMkfg38DVoRcQ6MiTXm4Y08u8Ro3UUq5a8CcLz00BhsUWjBo" //"pk_test_51KUECASIKGRzoIqjbSM2V9CY5yAmpLZqyuAk8tjsBhBW2yD7R3baBIehtbRm3sk0iI2WY5SVfdPfll9UdIsmNwtv00uNJJoJxw" //"pk_live_51KBjHoCFvjCP6HVsJR48GetH130VCq0pWcDacTn3WcxZ6tIt4R60mH0D3DQKtiuiivypyYsUT7VHJ1qgonfToCPZ00MMTwkHXJ"

         if #available(iOS 13.0, *) {
           window?.overrideUserInterfaceStyle = .light
       }
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions:
            launchOptions
        )
        // Override point for customization after application launch.
        return true
    }
    
    func application(
            _ app: UIApplication,
            open url: URL,
            options: [UIApplication.OpenURLOptionsKey : Any] = [:]
        ) -> Bool {
            ApplicationDelegate.shared.application(
                app,
                open: url,
                sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                annotation: options[UIApplication.OpenURLOptionsKey.annotation]
            )
            
            var handled: Bool

            handled = GIDSignIn.sharedInstance.handle(url)
            if handled {
              return true
            }
           return false
          }
  }


