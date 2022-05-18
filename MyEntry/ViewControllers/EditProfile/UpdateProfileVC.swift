//
//  UpdateProfileVC.swift
//  MyEntry
//
//  Created by Kinjal panchal on 04/12/21.
//

import UIKit
import CountryPickerView
import SDWebImage


class UpdateProfileVC: UIViewController {
    
    //MARK:- ===== Outlets ======
    @IBOutlet weak var txtBirthDate: ThemeSkyTextfield!
    @IBOutlet weak var txtDiatryType: ThemeSkyTextfield!
    @IBOutlet weak var viewCountryPicker: CountryPickerView!
    @IBOutlet weak var txtCountryCode: ThemeSkyTextfield!
    @IBOutlet weak var btnCountryPicker: UIButton!
    @IBOutlet weak var txtPhoneNumber: ThemeSkyTextfield!
    @IBOutlet weak var txtEmail: ThemeSkyTextfield!
    @IBOutlet weak var txtUserName: ThemeSkyTextfield!
    @IBOutlet weak var imgProfile: UIImageView!
    

    //MARK:- ====== Variables =====
    let countryPickerView = CountryPickerView()
    private lazy var imagePicker: ImagePicker = {
            let imagePicker = ImagePicker()
            imagePicker.delegate = self
            return imagePicker
        }()
    let updateProfileReqModel = UpdateProfileReqModel()
    let datePickerView:UIDatePicker = UIDatePicker()
    let diatryPicker = UIPickerView()

    
    //MARK:- ====== View Controller Life Cycle =====
    override func viewDidLoad() {
        super.viewDidLoad()
        datePickerView.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePickerView.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        diatryPicker.dataSource = self
        diatryPicker.delegate = self
        txtDiatryType.inputView = diatryPicker
        txtBirthDate.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: UIControl.Event.valueChanged)
        dataSetup()
        countryPickerView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    //MARK:- ==== Btn Action value Changed ======
    @objc func datePickerValueChanged(sender:UIDatePicker) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.medium
            dateFormatter.timeStyle = DateFormatter.Style.none
            dateFormatter.dateFormat = "dd MMM yyyy"
            datePickerView.maximumDate = Date()
            txtBirthDate.text = dateFormatter.string(from: sender.date)
       }
    
    //MARK:-===== DataSetup =======
    func dataSetup(){
        if Singleton.sharedInstance.UserProfilData?.image != "" {
            //imgProfile.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgProfile.sd_setImage(with: URL(string: Singleton.sharedInstance.UserProfilData?.image ?? ""), placeholderImage: UIImage(named: "account"))
        }
        else {
            imgProfile.image = UIImage(named: "account")
        }
        
        countryPickerView.delegate = self
        viewCountryPicker.showCountryCodeInView = false
        viewCountryPicker.setCountryByPhoneCode("\(Singleton.sharedInstance.UserProfilData?.phoneCode ?? "")")
        viewCountryPicker.font = CustomFont.Medium.returnFont(16.0)
        viewCountryPicker.textColor =  colors.ThemeGray.value
        updateProfileReqModel.phone_code = "\(Singleton.sharedInstance.UserProfilData?.phoneCode ?? "")"
       // countryPickerView.setCountryByCode("+1")
        //txtCountryCode.text = "+1"
       // countryPickerView.font = CustomFont.SemiBold
        
        txtEmail.text = Singleton.sharedInstance.UserProfilData?.email
        txtPhoneNumber.text = Singleton.sharedInstance.UserProfilData?.phone
       // txtCountryCode.text = "\(Singleton.sharedInstance.UserProfilData?.phoneCode ?? "")"
        txtBirthDate.text = Singleton.sharedInstance.UserProfilData?.birthDate
        txtDiatryType.text = Singleton.sharedInstance.UserProfilData?.type
        txtUserName.text = Singleton.sharedInstance.UserProfilData?.username
    }
    
    //MARK:- ====== Btn Action Back ===
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- ====== Btn Action Save ===
    @IBAction func btnActionSave(_ sender: UIButton) {
        let isValidator = validation()
        if isValidator.0 == false{
            AlertMessage.showMessageForError(isValidator.1)
        }
        else {
            webServiceCallUpdateProfile()
        }

    }
    
    @IBAction func btnActionCountryPicker(_ sender: UIButton) {
        countryPickerView.showCountriesList(from: self)
    }
    
    
    //MARK:- ====== Profile action ==
    @IBAction func btnActionProfile(_ sender: UIButton) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.imagePicker.cameraAsscessRequest()
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.imagePicker.photoGalleryAsscessRequest()
        }))
        alert.addAction(UIAlertAction(title: "Remove Photo", style: .default, handler: { _ in
            self.removeProfile()
        }))
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- ==== Validation =====
    func validation()->(Bool,String) {
        var msg = ""
        var isValid = true
        if (txtUserName.text?.isEmptyOrWhitespace())! {
            msg = "Please enter username"
        }
        else if (txtEmail.text?.isEmptyOrWhitespace())! {
            msg = "Please enter email."
        }
        else if !UtilityClass.isValidEmail(testStr:txtEmail.text!){
            msg = "Please enter valid email."
        }
        else if (txtPhoneNumber.text?.isEmptyOrWhitespace())! {
            msg = "Please enter phonenumber."
        }
        else if (txtPhoneNumber.text?.digitsOnly().count)! <= 6 {
            msg = "Please enter valid phonenumber."
        }
        else if imgProfile.image == UIImage(named: "account"){
            msg = "Please upload profile pic."
        }
        isValid = msg == "" ? true :  false
        return(isValid , msg)
      }
    
    //MARK:- ===== Webservice call remove Profile ====
    func removeProfile(){
        LoaderClass.showActivityIndicator()
        let reqModel = removeProfileReqModel()
        reqModel.user_id = Singleton.sharedInstance.UserId
        WebServiceSubClass.removeProfilePic(RemoveProfileReqModel: reqModel) { status, message, response, error in
            LoaderClass.hideActivityIndicator()
            if status {
                print(response)
                self.imgProfile.image = UIImage(named: "account")
                do {
                 self.view.endEditing(true)
                    try userDefaults.set(object: response?.data, forKey: UserDefaultsKey.userProfile.rawValue)
                    UserDefaults.standard.set(true, forKey: UserDefaultsKey.isUserLogin.rawValue)
                    Singleton.sharedInstance.UserProfilData = response?.data
                    AlertMessage.showMessageForSuccess(response?.message ?? "")

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
    
    //MARK:- ===== Webservice Call Update Profile ====
    func webServiceCallUpdateProfile(){
        LoaderClass.showActivityIndicator()
        updateProfileReqModel.userId = Singleton.sharedInstance.UserId
        updateProfileReqModel.phone = txtPhoneNumber.text
        updateProfileReqModel.username = txtUserName.text
        updateProfileReqModel.email = txtEmail.text
        updateProfileReqModel.birthdate = txtBirthDate.text
        updateProfileReqModel.type = txtDiatryType.text
        WebServiceSubClass.UpdateProfile(UpdateProfileModel: updateProfileReqModel, image: imgProfile.image ?? UIImage()) { status, message, response, error in
            LoaderClass.hideActivityIndicator()
            if status {
                print(response)
                do {
                 self.view.endEditing(true)
                    try userDefaults.set(object: response?.data, forKey: UserDefaultsKey.userProfile.rawValue)
                    UserDefaults.standard.set(true, forKey: UserDefaultsKey.isUserLogin.rawValue)
                    Singleton.sharedInstance.UserProfilData = response?.data
                    NotificationCenter.default.post(name:NSNotification.Name(NotificationKeys.kuserProfileKey.rawValue), object: nil)
                    AlertMessage.showMessageForSuccess(response?.message ?? "")
                    self.navigationController?.popViewController(animated: true)

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

//MARK: ======= ImagePickerDelegate =========
extension UpdateProfileVC : ImagePickerDelegate {
    
    func imagePicker(_ imagePicker: ImagePicker, didSelect image: UIImage) {
        imgProfile.image = image
        imagePicker.dismiss()
    }

    func cancelButtonDidClick(on imageView: ImagePicker) { imagePicker.dismiss() }
    
    func imagePicker(_ imagePicker: ImagePicker, grantedAccess: Bool,
                     to sourceType: UIImagePickerController.SourceType) {
        guard grantedAccess else { return }
        imagePicker.present(parent: self, sourceType: sourceType)
    }
  }

extension UpdateProfileVC : CountryPickerViewDelegate {
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        print(country)
        updateProfileReqModel.phone_code = country.phoneCode
        countryPickerView.setCountryByPhoneCode(country.phoneCode)
      //  txtCountryCode.text = country.phoneCode
        //registerModel.phone_code = country.phoneCode
    }
}
extension UpdateProfileVC : UIPickerViewDataSource , UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Singleton.sharedInstance.diatryList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Singleton.sharedInstance.diatryList[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtDiatryType.text = Singleton.sharedInstance.diatryList[row]
    }
}
