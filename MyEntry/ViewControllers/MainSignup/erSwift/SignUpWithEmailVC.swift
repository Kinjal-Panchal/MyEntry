//
//  SignUpWithEmailVC.swift
//  MyEntry
//
//  Created by panchal kinjal  on 08/09/21.
//

import UIKit

class SignUpWithEmailVC: UIViewController {
    
    //MARK:- ====== Outlets =======
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    
    
    let registereqModel = RegisterRequestModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK:- ==== Btn Action Back ====
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

    @IBAction func btnActionContinue(_ sender: UIButton) {
         let isValidator = validation()
         if isValidator.0 == false{
             AlertMessage.showMessageForError(isValidator.1)
         }
        else {
            webserviceCallWithEmail()
        }
    }
    
    //MARK:- ==== Validation =====
    func validation()->(Bool,String) {
        var msg = ""
        var isValid = true
        if (txtUserName.text?.isEmptyOrWhitespace())! {
            msg = "Please enter username."
        }
        else if (txtEmail.text?.isEmptyOrWhitespace())! {
            msg = "Please enter email."
        }
        else if !UtilityClass.isValidEmail(testStr:txtEmail.text!){
            msg = "Please enter valid email."
        }
        else if (txtPassword.text?.isEmptyOrWhitespace())! {
            msg = "Please enter password."
        }
        else if txtPassword.text!.count <= 5{
            msg = "Password must contain atleast 6 characters."
        }
        isValid = msg == "" ? true :  false
        return(isValid , msg)
        
    }
    
    //MARK:- ===== WebserviceCall With Email ======
    func webserviceCallWithEmail(){
        LoaderClass.showActivityIndicator()
        let reqModel = RegisterRequestModel()
        reqModel.email = txtEmail.text
        reqModel.password = txtPassword.text
        reqModel.username = txtUserName.text
        WebServiceSubClass.RegisterApi(reqModel: reqModel) { status, message, response, error in
            LoaderClass.hideActivityIndicator()
            print(response ?? nil)
            if status {
                UtilityClass.OkalerwithAction(Msg: response?.message ?? "") {
                    self.txtEmail.text = ""
                    self.txtPassword.text = ""
                    self.txtUserName.text = ""
                    let signinVc = SignInVC.instantiate(appStoryboard: .Auth)
                    self.navigationController?.pushViewController(signinVc, animated: true)
                }
//                do {
//                 self.view.endEditing(true)
//                    try userDefaults.set(object: response?.data, forKey: UserDefaultsKey.userProfile.rawValue)
//                    UserDefaults.standard.set(true, forKey: UserDefaultsKey.isUserLogin.rawValue)
//                    Singleton.sharedInstance.UserProfilData = response?.data
//                    let verificationVC = OTPVerificationVC.instantiate(appStoryboard: .Auth)
//                    self.navigationController?.pushViewController(verificationVC, animated: true)
//
//
//                  }
//                  catch let DecodingError.dataCorrupted(context) {
//                       print(context)
//                   } catch let DecodingError.keyNotFound(key, context) {
//                       print("Key '\(key)' not found:", context.debugDescription)
//                       print("codingPath:", context.codingPath)
//                   } catch let DecodingError.valueNotFound(value, context) {
//                       print("Value '\(value)' not found:", context.debugDescription)
//                       print("codingPath:", context.codingPath)
//                   } catch let DecodingError.typeMismatch(type, context)  {
//                       print("Type '\(type)' mismatch:", context.debugDescription)
//                       print("codingPath:", context.codingPath)
//                   } catch {
//                       print("error: ", error)
//                   }
               }
            else {
                
                AlertMessage.showMessageForError(message)
                
               }
                
//                let otpVC = OTPVC.instantiate(appStoryboard: .Auth)
//                self.navigationController?.pushViewController(otpVC, animated: true)
            }
            
        }
        
    
    //MARK:- ===== Webservice Call Resend OTP =====
    func webServiceCallOTP(){
        LoaderClass.showActivityIndicator()
        let otpreqModel = OTPReqModel()
        otpreqModel.identity = "email"
        otpreqModel.type = txtEmail.text
        
        WebServiceSubClass.SendOTP(reqModel: otpreqModel) { [self] status, message, response, error in
            LoaderClass.hideActivityIndicator()
            if status {
                print(response)
                self.registereqModel.username = self.txtUserName.text
                self.registereqModel.email = self.txtEmail.text
                self.registereqModel.password = self.txtPassword.text
                AlertMessage.showMessageForSuccess(response?.otp ?? "")
                let otpVC : OTPVC = OTPVC.instantiate(appStoryboard: .Auth)
                otpVC.StringOTP = response?.otp ?? ""
                otpVC.isFromEmail = true
                otpVC.registerEmailReqModel = registereqModel
                self.navigationController?.pushViewController(otpVC, animated: true)

            }
            else {
                AlertMessage.showMessageForError(message)
            }
        }
    }

        
    }
    


