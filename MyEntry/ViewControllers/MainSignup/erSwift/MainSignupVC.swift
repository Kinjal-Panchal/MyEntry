//
//  MainSignupVC.swift
//  MyEntry
//
//  Created by panchal kinjal  on 08/09/21.
//

import UIKit
import GoogleSignIn

class MainSignupVC: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    var googleSignInManager : GoogleLoginProvider?
    var FacebookSignInManager : FacebookLoginProvider?
    var appleSignInManager : AppleSignInProvider?

    
    //MARK:- ===== Btn Action sign up with phone ====
    @IBAction func btnActionSignUpWithPhone(_ sender: UIButton) {
        let signupWithPhoneVc = SignUpWithPhoneVC.instantiate(appStoryboard: .Auth)
        self.navigationController?.pushViewController(signupWithPhoneVc, animated: true)
    }
    
    //MARK:- ==== Btn Action Google ==
    @IBAction func btnActionGoogle(_ sender: UIButton) {
        self.googleSignInManager = GoogleLoginProvider(self)
        self.googleSignInManager?.delegate = self
    }
    
    //MARK:- ==== Btn Action Facebook ==
    @IBAction func btnActionFacebook(_ sender: UIButton) {
        self.FacebookSignInManager = FacebookLoginProvider(self)
        self.FacebookSignInManager?.delegate = self
    }
    
    //MARK:- ==== Btn Action Apple ==
    @IBAction func btnActionApple(_ sender: UIButton) {
        self.appleSignInManager = AppleSignInProvider()
        self.appleSignInManager?.delegate = self
    }
    
    //MARK:- ===== Btn Action sign up with email ====
    @IBAction func btnActionSignUpEmail(_ sender: UIButton) {
        let signupWithEmailVc = SignUpWithEmailVC.instantiate(appStoryboard: .Auth)
        self.navigationController?.pushViewController(signupWithEmailVc, animated: true)
    }
    
    @IBAction func btnActionSignIn(_ sender: Any) {
        let signInVc = SignInVC.instantiate(appStoryboard: .Auth)
        self.navigationController?.pushViewController(signInVc, animated: true)
    }
}

//MARK:- Social Sign In
extension MainSignupVC: SocialSignInDelegate{
    func FetchUser(socialType: SocialType, success: Bool, user: SocialUser?, error: String?) {
         LoaderClass.showActivityIndicator()
        if let userObj = user{
            if  socialType == .Apple {
                let reqModel = AppleLoginRequestModel()
                reqModel.email = userObj.email
                reqModel.username = (user?.firstName ?? "") + " " + (user?.lastName ?? "")
                reqModel.appleid = user?.userId
                
                WebServiceSubClass.appleLogin(reqModel: reqModel) { status, message, response, error in
                    LoaderClass.hideActivityIndicator()
                    if status {
                        print(response)
                        do {
                         self.view.endEditing(true)
                            try userDefaults.set(object: response?.data, forKey: UserDefaultsKey.userProfile.rawValue)
                            UserDefaults.standard.set(true, forKey: UserDefaultsKey.isUserLogin.rawValue)
                            Singleton.sharedInstance.UserProfilData = response?.data
                            Singleton.sharedInstance.UserId = "\(response?.data?.id ?? 0)"
                            Appdel.navigateToHome()
                            
                          }
                          catch let DecodingError.dataCorrupted(context) {
                               print(context)
                           } catch let DecodingError.keyNotFound(key, context) {
                               print("Key '\(key)' not found:", context.debugDescription)
                               print("codingPath:", context.codingPath)
                           } catch let DecodingError.valueNotFound(value, context) {
                               print("Value '\(value)' not found:", context.debugDescription)
                               print("codingPath:", context.codingPath)
                           } catch let DecodingError.typeMismatch(type, context)  {
                               print("Type '\(type)' mismatch:", context.debugDescription)
                               print("codingPath:", context.codingPath)
                           } catch {
                               print("error: ", error)
                           }
                       }
                    else{
                        LoaderClass.hideActivityIndicator()
                        AlertMessage.showMessageForError(message)
                    }
                    }
                }
            
         else {
            let reqModel = SocialLoginRequestModel()
            reqModel.identity = userObj.email
            reqModel.login_type = user?.socialType
            reqModel.username = (user?.firstName ?? "") + " " + (user?.lastName ?? "")
            
            WebServiceSubClass.SocialLogin(reqModel: reqModel) { status, message, response, error in
                LoaderClass.hideActivityIndicator()
                if status {
                    print(response)
                    do {
                     self.view.endEditing(true)
                        try userDefaults.set(object: response?.data, forKey: UserDefaultsKey.userProfile.rawValue)
                        UserDefaults.standard.set(true, forKey: UserDefaultsKey.isUserLogin.rawValue)
                        Singleton.sharedInstance.UserProfilData = response?.data
                        Singleton.sharedInstance.UserId = "\(response?.data?.id ?? 0)"
                        Appdel.navigateToHome()
                        
                      }
                      catch let DecodingError.dataCorrupted(context) {
                           print(context)
                       } catch let DecodingError.keyNotFound(key, context) {
                           print("Key '\(key)' not found:", context.debugDescription)
                           print("codingPath:", context.codingPath)
                       } catch let DecodingError.valueNotFound(value, context) {
                           print("Value '\(value)' not found:", context.debugDescription)
                           print("codingPath:", context.codingPath)
                       } catch let DecodingError.typeMismatch(type, context)  {
                           print("Type '\(type)' mismatch:", context.debugDescription)
                           print("codingPath:", context.codingPath)
                       } catch {
                           print("error: ", error)
                       }
                   }
                else{
                    LoaderClass.hideActivityIndicator()

                    AlertMessage.showMessageForError(message)
                }
            }
            }
        }
        LoaderClass.hideActivityIndicator()
    }
}
