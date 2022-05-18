//
//  AppDelegate+Methods.swift
//  PickARide User
//
//  Created by apple on 6/29/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation
import SideMenuSwift
import IQKeyboardManagerSwift

extension AppDelegate{
    
    func navigateToLogin(){
        let loginVc = MainSignupVC.instantiate(appStoryboard: .Auth)
        let NavHomeVC = UINavigationController(rootViewController: loginVc)
        NavHomeVC.navigationBar.isHidden = true
        self.window?.rootViewController = NavHomeVC
    }

    func navigateToHome() {
          let storyborad = UIStoryboard(name: "Main", bundle: nil)
         let CustomSideMenu = storyborad.instantiateViewController(withIdentifier: "SideMenuController") as! SideMenuController
         let NavHomeVC = UINavigationController(rootViewController: CustomSideMenu)
         NavHomeVC.isNavigationBarHidden = true
        self.window?.rootViewController = NavHomeVC
    
        //UIApplication.shared.keyWindow?.rootViewController = NavHomeVC
    }
    
    func clearData(){
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            
            if key != UserDefaultsKey.DeviceToken.rawValue && key  != "language"  {
                print("\(key) = \(value) \n")
                 UserDefaults.standard.removeObject(forKey: key)
            }
        }
        userDefaults.set(false, forKey: UserDefaultsKey.isUserLogin.rawValue)
        Singleton.sharedInstance.clearSingletonClass()
        //userDefaults.setUserData()
    }
    
    func dologout(){
        clearData()
        self.navigateToLogin()
        
    }
    
    
}
