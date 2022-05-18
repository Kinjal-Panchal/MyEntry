//
//  ChangePasswordVC.swift
//  MyEntry
//
//  Created by Kinjal panchal on 04/12/21.
//

import UIKit

class ChangePasswordVC: UIViewController {
    
    //MARK:- ===== Outlets =====
    @IBOutlet weak var txtConfirmPassword: ThemeSkyTextfield!
    @IBOutlet weak var txtNewPassword: ThemeSkyTextfield!
    @IBOutlet weak var txtCurrentPassword: ThemeSkyTextfield!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActionSubmit(_ sender: UIButton) {
        let isValid = validation()
        if isValid.0 == false{
            AlertMessage.showMessageForError(isValid.1)
        }
       else {
           webServiceCallChangePassword()
       }
    }
    
    //MARK:- ==== Validation =====
    func validation()->(Bool,String) {
        var msg = ""
        var isValid = true
        if (txtCurrentPassword.text?.isEmptyOrWhitespace())! {
            msg = "Please enter current password."
        }
        else if (txtNewPassword.text?.isEmptyOrWhitespace())! {
            msg = "Please enter new password."
        }
        else if txtNewPassword.text!.count <= 5{
            msg = "Password must contain atleast 6 characters."
        }
        else if (txtConfirmPassword.text?.isEmptyOrWhitespace())! {
            msg = "Please enter confirm password."
        }
        else if txtNewPassword.text != txtConfirmPassword.text{
            msg = "New password and confirm password does not match."
        }
        isValid = msg == "" ? true :  false
        return(isValid , msg)
    }
    
    
    //MARK:-==== ChangePassword WebService Call ====
    func webServiceCallChangePassword(){
        LoaderClass.showActivityIndicator()
        let reqModel = ChangePasswordReqModel()
        reqModel.user_id = Singleton.sharedInstance.UserId
        reqModel.current_password =  txtCurrentPassword.text
        reqModel.new_password = txtNewPassword.text
        reqModel.new_confirm_password = txtConfirmPassword.text
        WebServiceSubClass.changePassword(changePassReqModel: reqModel) { status, message, response, error in
            LoaderClass.hideActivityIndicator()
            if status {
                print(response)
                AlertMessage.showMessageForSuccess(response?.message ?? "")
                self.navigationController?.popViewController(animated: true)
             }
            else {
                AlertMessage.showMessageForError(message)
            }
            
        }
    }
    

}
