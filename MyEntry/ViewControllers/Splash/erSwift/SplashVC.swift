//
//  SplashVC.swift
//  MyEntry
//
//  Created by panchal kinjal  on 11/09/21.
//

import UIKit

class SplashVC: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webServiceCallInit()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            //self.setRootViewController()
//            self.webServiceCallInit()
//        }
    }
    
    //MARK:- ===== Set RootViewController ======
    func setRootViewController() {
        let isLogin = UserDefaults.standard.bool(forKey: UserDefaultsKey.isUserLogin.rawValue)
        
        if isLogin, let _ = userDefaults.getUserData() {
            appDel.navigateToHome()
        }else{
            appDel.navigateToLogin()
        }
    }
    
    
    //MARK:- ===== Webservice Call Init ====
    func webServiceCallInit(){
        let param = [String:AnyObject]()
        var userId = String()
        let isLogin = UserDefaults.standard.bool(forKey: UserDefaultsKey.isUserLogin.rawValue)
            if isLogin, let userData = userDefaults.getUserData() {
                Singleton.sharedInstance.UserProfilData = userData
                userId = "\(Singleton.sharedInstance.UserProfilData?.id ?? 0)"
            }else{
                userId = "0"
            }
        
        WebServiceSubClass.webserviceInit(userId: userId, reqmodel: param) { status, message, response, error in
            
            if status {
                print(response)
                let objRes = response?.data
                Singleton.sharedInstance.diatryList = objRes ?? []
                self.setRootViewController()
            }
            else {
                AlertMessage.showMessageForError(message)
            }
        }
    }
}
