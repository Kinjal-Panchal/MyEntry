//
//  SignInVC.swift
//  MyEntry
//
//  Created by panchal kinjal  on 09/09/21.
//

import UIKit
import GoogleSignIn

class SignInVC: UIViewController {

    //MARK:- ===== Outlets ======
    @IBOutlet weak var txtemailUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnPreview: UIButton!
    
    
    var googleSignInManager : GoogleLoginProvider?
    var FacebookSignInManager : FacebookLoginProvider?
    var appleSignInManager : AppleSignInProvider?
    
    //MARK:- ==== Variables =====
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK:- ==== Btn Action Back ====
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActionGoogle(_ sender: UIButton) {
        self.googleSignInManager = GoogleLoginProvider(self)
        self.googleSignInManager?.delegate = self
    }
    
    @IBAction func btnActionFaceBook(_ sender: UIButton) {
        self.FacebookSignInManager = FacebookLoginProvider(self)
        self.FacebookSignInManager?.delegate = self
    }
    
    @IBAction func btnActionApple(_ sender: UIButton) {
        self.appleSignInManager = AppleSignInProvider()
        self.appleSignInManager?.delegate = self
    }
    
    @IBAction func btnActionContinue(_ sender: UIButton) {
        let isValidator = validation()
        if isValidator.0 == false{
            AlertMessage.showMessageForError(isValidator.1)
        }
       else {
           webServiceCallLogin()
       }
    }
    
    //MARK:- ====== Btn Action Password View =
    @IBAction func btnActionPasswordView(_ sender: UIButton) {
        btnPreview.isSelected = !btnPreview.isSelected
        txtPassword.isSecureTextEntry = btnPreview.isSelected ? false : true
    }
    
    //MARK:- ==== Validation =====
    func validation()->(Bool,String) {
        var msg = ""
        var isValid = true
        if (txtemailUserName.text?.isEmptyOrWhitespace())! {
            msg = "Please enter phone or email."
        }
        else if (txtPassword.text?.isEmptyOrWhitespace())! {
            msg = "Please enter password."
        }
        isValid = msg == "" ? true :  false
        return(isValid , msg)
    }
    
    //MARK:- ====== Webservice Login ======
     func webServiceCallLogin(){
        LoaderClass.showActivityIndicator()
         let loginreqModel = LoginReqModel()
         loginreqModel.identity = txtemailUserName.text
         loginreqModel.password = txtPassword.text
         WebServiceSubClass.login(reqModel: loginreqModel) { status, message, response, error in
             LoaderClass.hideActivityIndicator()
             if status {
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
             else {
                 AlertMessage.showMessageForError(message)
             }
           }
         }
}
//MARK:- Social Sign In
extension SignInVC: SocialSignInDelegate{
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
