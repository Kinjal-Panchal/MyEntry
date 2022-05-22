//
//  OTPVC.swift
//  MyEntry
//
//  Created by panchal kinjal  on 10/09/21.
//

import UIKit

protocol OTPTextFieldDelegate {
    
    func textFieldDidDelete(currentTextField: OTPTextField)
}

class OTPVC: UIViewController , OTPTextFieldDelegate{
    
    //MARK:- ====== Outlets ======
    @IBOutlet var txtOtp: [OTPTextField]!
    @IBOutlet weak var lblTimeDuration: UILabel!
    @IBOutlet weak var lblreceiveCode: UILabel!
    @IBOutlet weak var btnResendCode: UIButton!
    @IBOutlet weak var lblTitle: ThemTitleLabel!
    
    //MARK:- ===== Variables =====
    var textFieldsIndexes:[OTPTextField:Int] = [:]
    var StringOTP : String = ""
    var registerReqModel = RegisterPhoneRequestModel()
    var registerEmailReqModel = RegisterRequestModel()
    var isFromEmail = false
    var timer:Timer!
    var totalSecond = 60
    var mobilenumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        startTimer()
        if registerReqModel != nil && isFromEmail == false{
            let letters  = registerReqModel.mobile_number?.map({String($0)})
            print(letters! as [String])
            // ["A", "B", "C"]
            var str = [String]()
            for i in 0..<letters!.count{
                if i <= 2 {
                    str.append(letters![i])
                }
                else{
                    str.append("X")
                }
            }
            
//            let strNo = str.joined(separator: "")
//            lblTitle.text = "Please enter one time password which was sent to \(mobilenumber)\(strNo)"
            let strNo = str.joined(separator: "")
            lblTitle.text = "Please enter one time password which was sent to \(registerReqModel.phone_code ?? "")\(strNo)"
        
        txtOtp[0].becomeFirstResponder()

        for index in 0 ..< txtOtp.count {
            textFieldsIndexes[txtOtp[index]] = index
        }
        for txt in txtOtp {
            txt.delegate = self
        }
        txtOtp[0].myDelegate = self
        txtOtp[1].myDelegate = self
        txtOtp[2].myDelegate = self
        txtOtp[3].myDelegate = self
       }
    }
    
    //MARK:- === Start Timer ======
    func startTimer(){
        lblTimeDuration.text = "00.00"
        btnResendCode.isHidden = true
        lblreceiveCode.isHidden = true
        lblTimeDuration.isHidden = false
        self.timer = Timer.scheduledTimer(timeInterval: 1 ,
                                                      target: self,
                                                      selector: #selector(self.countdown),
                                                      userInfo: nil,
                                                      repeats: true)
    }
    
    @objc func countdown() {
        var hours: Int
        var minutes: Int
        var seconds: Int

        if totalSecond == 0 {
            StringOTP = ""
            lblreceiveCode.isHidden = false
            btnResendCode.isHidden = false
            lblTimeDuration.isHidden = true
            timer?.invalidate()
        }
        else {
            totalSecond = totalSecond - 1
            hours = totalSecond / 3600
            minutes = (totalSecond % 3600) / 60
            seconds = (totalSecond % 3600) % 60
            lblTimeDuration.text = String(format: "%02d:%02d", minutes, seconds)
        }
    }
    
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    //MARK:- ==== Btn Action Resend Code ===
    @IBAction func btnActionResendCode(_ sender: UIButton) {
        self.txtOtp.forEach { (textfield) in
            textfield.text = ""
        }
        self.totalSecond = 60
        self.startTimer()
        webServiceCallOTP()
    }
    
    @IBAction func btnActionContinue(_ sender: UIButton) {
        if self.validation(){
            isFromEmail == true ? webserviceCallWithEmail()  : webserviceCallWithPhone()
        }
    }
    func validation() -> Bool {
        var strTitle : String?
        var strEnteredOTP = ""
        for index in 0 ..< txtOtp.count {
            strEnteredOTP.append(txtOtp[index].text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
        }
        
        if strEnteredOTP == "" {
            strTitle = "Please enter OTP."
        }else if self.StringOTP != strEnteredOTP {
            self.clearAllFields()
            strTitle = "Please enter valid OTP."
        }
        
        if let str = strTitle{
            AlertMessage.showMessageForError(str ?? "")
            return false
        }
        return true
    }
    
    //MARK:- ===== Webservice Call Resend OTP =====
    func webServiceCallOTP(){
        LoaderClass.showActivityIndicator()
        let otpreqModel = OTPReqModel()
        otpreqModel.identity = isFromEmail == true ? "email" : "mobile"
        otpreqModel.type =  isFromEmail == true  ? registerEmailReqModel.email : registerReqModel.mobile_number
        
        WebServiceSubClass.SendOTP(reqModel: otpreqModel) { [self] status, message, response, error in
            LoaderClass.hideActivityIndicator()
            if status {
                print(response)
                StringOTP = response?.otp ?? ""
                AlertMessage.showMessageForSuccess(response?.otp ?? "")
            }
            else {
                AlertMessage.showMessageForError(message)
            }
        }
    }
    
    //MARK:- ===== WebserviceCall With Email ======
    func webserviceCallWithPhone(){
        LoaderClass.showActivityIndicator()
         let reqModel = RegisterPhoneRequestModel()
        reqModel.phone_code = registerReqModel.phone_code
        reqModel.mobile_number = registerReqModel.mobile_number
        reqModel.password = registerReqModel.password
        reqModel.username = registerReqModel.username
        WebServiceSubClass.RegisterWithPhoneApi(reqModel: reqModel) { status, message, response, error in
            LoaderClass.hideActivityIndicator()
            print(response ?? nil)
            if status {
                
                do {
                 self.view.endEditing(true)
                    try userDefaults.set(object: response?.data, forKey: UserDefaultsKey.userProfile.rawValue)
                    UserDefaults.standard.set(true, forKey: UserDefaultsKey.isUserLogin.rawValue)
                    Singleton.sharedInstance.UserProfilData = response?.data
                    Singleton.sharedInstance.UserId = "\(response?.data?.id ?? 0)"
                    let verificationVC = OTPVerificationVC.instantiate(appStoryboard: .Auth)
                    self.navigationController?.pushViewController(verificationVC, animated: true)
                    

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
                AlertMessage.showMessageForError(response?.message ?? "")
            }
          }
        }
    
    
    //MARK:- ===== WebserviceCall With Email ======
    func webserviceCallWithEmail(){
        LoaderClass.showActivityIndicator()
        let reqModel = RegisterRequestModel()
        reqModel.email = registerEmailReqModel.email
        reqModel.password = registerEmailReqModel.password
        reqModel.username = registerEmailReqModel.username
        WebServiceSubClass.RegisterApi(reqModel: reqModel) { status, message, response, error in
            LoaderClass.hideActivityIndicator()
            print(response ?? nil)
            if status {
                
                do {
                 self.view.endEditing(true)
                    try userDefaults.set(object: response?.data, forKey: UserDefaultsKey.userProfile.rawValue)
                    UserDefaults.standard.set(true, forKey: UserDefaultsKey.isUserLogin.rawValue)
                    Singleton.sharedInstance.UserProfilData = response?.data
                    let verificationVC = OTPVerificationVC.instantiate(appStoryboard: .Auth)
                    self.navigationController?.pushViewController(verificationVC, animated: true)
                    

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
                
//                let otpVC = OTPVC.instantiate(appStoryboard: .Auth)
//                self.navigationController?.pushViewController(otpVC, animated: true)
            }
            
        }
        
}


//MARK:- UITextFieldDelegate
extension OTPVC : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.length == 0 {
            setNextResponder(textFieldsIndexes[textField as! OTPTextField], direction: .right)
            textField.text = string
            return true
        } else if range.length == 1 {
            setNextResponder(textFieldsIndexes[textField as! OTPTextField], direction: .left)
            textField.text = ""
            return false
        }
        return false
    }
    
    func textFieldDidDelete(currentTextField: OTPTextField) {
        print("delete")
        setNextResponder(textFieldsIndexes[currentTextField], direction: .left)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        setNextResponderBlank(textFieldsIndexes[textField as! OTPTextField])
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    func setNextResponderBlank(_ index:Int?) {
        if index! >= 0 {
            let neIndex = index! + 1
            for i in neIndex..<txtOtp.count {
                txtOtp[i].text = ""
            }
        }
    }
    
    func setNextResponder(_ index:Int?, direction: Direction) {
        guard let index = index else { return }
        
        if direction == .left {
            index == 0 ?
                (_ = txtOtp.first?.resignFirstResponder()) :
                (_ = txtOtp[(index - 1)].becomeFirstResponder())
            if index > 0 {
                let neIndex = index + 1
                for i in neIndex..<txtOtp.count {
                    txtOtp[i].text = ""
                }
            }
        } else {
            index == txtOtp.count - 1 ?
                (_ = txtOtp.last?.resignFirstResponder()) :
                (_ = txtOtp[(index + 1)].becomeFirstResponder())
        }
    }
    
    func clearAllFields() {
        for index in 0 ..< txtOtp.count {
            txtOtp[index].text = ""
        }
    }
}

class OTPTextField: UITextField {
    var myDelegate: OTPTextFieldDelegate?
    
    override func deleteBackward() {
        super.deleteBackward()
        myDelegate?.textFieldDidDelete(currentTextField: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.textAlignment = .center
        //self.layer.cornerRadius = 16
        self.clipsToBounds = true
        //self.layer.borderColor = UIColor.black.cgColor
       // self.layer.borderWidth = 0
        self.font = CustomFont.Medium.returnFont(17)
        self.tintColor = colors.ThemeGray.value
    }
}

enum Direction { case left, right }

//MARK:- Validation & Apis
