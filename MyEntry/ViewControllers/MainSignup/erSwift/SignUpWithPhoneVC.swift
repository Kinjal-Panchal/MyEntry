//
//  SignUpWithPhoneVC.swift
//  MyEntry
//
//  Created by panchal kinjal  on 08/09/21.
//

import UIKit
import CountryPickerView

class SignUpWithPhoneVC: UIViewController {
    
    //MARK:- ====== Outlets =====
    @IBOutlet weak var viewcountryPicker: CountryPickerView!
    @IBOutlet weak var txtCountryCode: ThemeSkyTextfield!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    //MARK:- ====== Variables =====
    let countryPickerView = CountryPickerView()
    var registerModel = RegisterPhoneRequestModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryPickerView.delegate = self
        viewcountryPicker.showCountryCodeInView = false
        viewcountryPicker.setCountryByPhoneCode("+1")
        viewcountryPicker.font = CustomFont.Medium.returnFont(16.0)
        viewcountryPicker.textColor =  colors.ThemeGray.value

       // countryPickerView.setCountryByCode("+1")
        //txtCountryCode.text = "+1"
       // countryPickerView.font = CustomFont.SemiBold
        registerModel.phone_code = viewcountryPicker.selectedCountry.phoneCode
    }
    
    
    //MARK:- ==== Btn Action Back ====
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

    @IBAction func btnActionCountryPicker(_ sender: UIButton) {
        countryPickerView.showCountriesList(from: self)
        
    }
    
    @IBAction func btnActionContinue(_ sender: UIButton) {
        let isValidator = validation()
        if isValidator.0 == false{
            AlertMessage.showMessageForError(isValidator.1)
        }
       else {
           webServiceCallOTP()
       }
    }
    
    
    //MARK:- ==== Validation =====
    func validation()->(Bool,String) {
        var msg = ""
        var isValid = true
        if (txtUserName.text?.isEmptyOrWhitespace())! {
            msg = "Please enter username."
        }
        else if (txtPhoneNumber.text?.isEmptyOrWhitespace())! {
            msg = "Please enter phonenumber."
        }
        else if (txtPhoneNumber.text?.digitsOnly().count)! <= 6 {
            msg = "Please enter valid phonenumber."
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
    
    
    //MARK:- ===== Webservice Call Resend OTP =====
    func webServiceCallOTP(){
        LoaderClass.showActivityIndicator()
        let otpreqModel = OTPReqModel()
        otpreqModel.identity = "mobile"
        otpreqModel.type = txtPhoneNumber.text
    
        WebServiceSubClass.SendOTP(reqModel: otpreqModel) { [self] status, message, response, error in
            LoaderClass.hideActivityIndicator()
            if status {
                print(response)
                //self.registerModel.phone_code = self.txtCountryCode.text
                self.registerModel.username = self.txtUserName.text
                self.registerModel.password = self.txtPassword.text
                self.registerModel.mobile_number = self.txtPhoneNumber.text
                AlertMessage.showMessageForSuccess(response?.otp ?? "")
                let otpVC : OTPVC = OTPVC.instantiate(appStoryboard: .Auth)
                otpVC.StringOTP = response?.otp ?? ""
                otpVC.registerReqModel = registerModel
                self.navigationController?.pushViewController(otpVC, animated: true)

            }
            else {
                AlertMessage.showMessageForError(message)
            }
        }
    }
}

extension SignUpWithPhoneVC : CountryPickerViewDelegate {
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        countryPickerView.setCountryByPhoneCode(country.phoneCode)
//        txtCountryCode.text = country.phoneCode
        registerModel.phone_code = country.phoneCode
      }
    
}

