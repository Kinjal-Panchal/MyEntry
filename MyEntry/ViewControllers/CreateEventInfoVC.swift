//
//  CreateEventInfoVC.swift
//  MyEntry
//
//  Created by Kinjal Panchal on 25/10/21.
//

import UIKit
import GooglePlaces

class CreateEventInfoVC: UIViewController {

    //MARK:- ====== Outlets =======
    @IBOutlet weak var switchPublicEvent: UISwitch!
    @IBOutlet weak var switchallDayEvent: UISwitch!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtVenue: UITextField!
    @IBOutlet weak var txtToTime: UITextField!
    @IBOutlet weak var txtFromTime: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var txtEventTitle: UITextField!
    @IBOutlet weak var txtCity: ThemeGrayTextfield!
    @IBOutlet weak var txtCountry: ThemeGrayTextfield!
    @IBOutlet weak var viewStartEnd: UIView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var lbltitle: ThemTitleLabel!
    @IBOutlet weak var viewContinue: UIView!
    
    
    //MARK:- ==== Variables =====
    let datePickerView:UIDatePicker = UIDatePicker()
    let fromtimePicker:UIDatePicker = UIDatePicker()
    let ToTimePicker :UIDatePicker = UIDatePicker()
    var createEventrequestModel = CreateEventReqModel()
    var objEvent : EventData!

    //MARK:- ==== ViewController Life Cycle =====
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSetup()
        txtAddress.delegate = self
        datePickerView.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePickerView.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.4, *) {
            fromtimePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.4, *) {
            ToTimePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        fromtimePicker.datePickerMode = .time
        ToTimePicker.datePickerMode = .time
        txtDate.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: UIControl.Event.valueChanged)
        txtFromTime.inputView = fromtimePicker
        txtToTime.inputView = ToTimePicker
        fromtimePicker.addTarget(self, action: #selector(fromPickerValueChanged), for: .valueChanged)
        ToTimePicker.addTarget(self, action: #selector(toPickerValueChanged), for: .valueChanged)
        switchPublicEvent.addTarget(self, action: #selector(publicEventValueChanged), for:.valueChanged)
        switchallDayEvent.addTarget(self, action: #selector(allDayEventValueChanged), for:.valueChanged)
    }
    
    func dataSetup(){
        btnSave.setTitle("Save", for: .normal)
        btnSave.titleLabel?.font = CustomFont.Medium.returnFont(15.0)
        btnSave.setTitleColor(colors.ThemeGray.value, for: .normal)
        if objEvent != nil {
            viewContinue.isHidden = true
            btnSave.isHidden = false
            lbltitle.text = "Edit Event"
            txtCity.text = objEvent.city
            txtCountry.text = objEvent.country
            txtDate.text = UtilityClass.DateStringChange(Format:StrdateFormatter.StrYMD.rawValue, getFormat: StrdateFormatter.strDMY.rawValue, dateString: objEvent.eventDate ?? "")
            txtEventTitle.text = objEvent.eventTitle
            txtDescription.text = objEvent.datumDescription
            txtVenue.text = objEvent.venueLink
            txtAddress.text = objEvent.address
            switchallDayEvent.isOn = objEvent.allDayEvent == "yes" ? true : false
            switchPublicEvent.isOn = objEvent.isPublicEvent == "yes" ? true : false
            viewStartEnd.isHidden = switchallDayEvent.isOn
            txtFromTime.text = objEvent.startTime
            txtToTime.text = objEvent.endTime
        }
        else {
            viewContinue.isHidden = false
            btnSave.isHidden = true
        }
    }
    
    //MARK:- ==== Btn Action Back ======
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func allDayEventValueChanged(mySwitch: UISwitch) {
            let value = mySwitch.isOn
            viewStartEnd.isHidden = mySwitch.isOn
            print("switch value changed \(value)")
     }
    
    @objc func publicEventValueChanged(mySwitch: UISwitch) {
         let value = mySwitch.isOn
         print("switch value changed \(value)")
     }
    
    //MARK:- ==== Btn Action Continue ======
    @IBAction func btnActionContinue(_ sender: UIButton) {
        let isvalidator = validation()
        if isvalidator.0 == false {
            AlertMessage.showMessageForError(isvalidator.1)
        }
        else {
            createEventrequestModel.event_title = txtEventTitle.text
            createEventrequestModel.description = txtDescription.text
            createEventrequestModel.event_date = UtilityClass.DateStringChange(Format: "dd MMM yyyy", getFormat: DateFormatterString.onlyDate.rawValue, dateString: txtDate.text ?? "")
          //  createEventrequestModel.event_time = "\(txtFromTime.text ?? "")-\(txtToTime.text ?? "")"
            createEventrequestModel.all_day_event = switchallDayEvent.isOn == true ? "yes" : "no"
            createEventrequestModel.venue_link = txtVenue.text
            createEventrequestModel.address = txtAddress.text
            createEventrequestModel.is_public_event = switchPublicEvent.isOn == true ? "yes" : "no"
            createEventrequestModel.country = txtCountry.text ?? ""
            createEventrequestModel.city = txtCity.text ?? ""
            createEventrequestModel.startTime = txtFromTime.text ?? ""
            createEventrequestModel.endTime = txtToTime.text ?? ""
            
        let eventinfoVC : AdditionalSettingVC = AdditionalSettingVC.instantiate(appStoryboard: .main)
        eventinfoVC.createEventrequestModel = createEventrequestModel
            self.navigationController?.pushViewController(eventinfoVC, animated: true)
        }
    }
    
   //MARK:- ==== Btn Action value Changed ======
   @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateFormat = "dd MMM yyyy"
        datePickerView.minimumDate = Calendar.current.date(byAdding:.day, value: 1, to: Date())
        txtDate.text = dateFormatter.string(from: sender.date)
    }
    
    //MARK:- ===== timePicker =====
    @objc func fromPickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.dateFormat = "hh:mm a"
        txtFromTime.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func toPickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.dateFormat = "hh:mm a"
        //let min = dateFormatter.date(from: txtFromTime.text ?? "")      //createing min time
        //let max = dateFormatter.date(from: "21:00") //creating max time
        //ToTimePicker.minimumDate = min  //setting min time to picker
       // datePicker.maximumDate = max  //setting max time to picker
        txtToTime.text = dateFormatter.string(from: sender.date)
     }
    
    //MARK:- ===== Validation =====
    func validation() ->(Bool,String){
        var msg = ""
        var isvalid = true
        if (txtEventTitle.text?.isEmptyOrWhitespace())! {
            msg = "Please enter event title"
        }
        else if (txtDescription.text?.isEmptyOrWhitespace())! {
           msg = "Please enter event description"
        }
        else if (txtDate.text?.isEmptyOrWhitespace())! {
           msg = "Please select event date"
        }
        else if (txtVenue.text?.isEmptyOrWhitespace())!{
            msg = "Please enter venue details."
        }
        
//        else if !(txtVenue.text?.isEmptyOrWhitespace())!{
//          if !(txtVenue.text?.isStringLink())! {
//            msg = "Please enter venue or venuelink."
//          }
          else if (txtAddress.text?.isEmptyOrWhitespace())! {
            msg = "Please enter address"
          }
          else if (txtCity.text?.isEmptyOrWhitespace())!{
             msg = "Please enter city."
         }
         else if (txtCountry.text?.isEmptyOrWhitespace())! {
             msg = "Please enter country."
          }
       // }
        else if switchallDayEvent.isOn == false {
         if (txtFromTime.text?.isEmptyOrWhitespace())!{
             msg = "Please select event start time"
           }
         else if (txtToTime.text?.isEmptyOrWhitespace())! {
           msg = "Please select event end time"
         }
        //}
        else if (txtVenue.text?.isEmptyOrWhitespace())!{
            msg = "Please enter venue details."
        }
//         else if !(txtVenue.text?.isEmptyOrWhitespace())!{
//          if !(txtVenue.text?.isStringLink())! {
//            msg = "Please enter venue or venuelink."
//          }
//         }
        else if (txtAddress.text?.isEmptyOrWhitespace())! {
          msg = "Please enter address"
        }
        else if (txtCity.text?.isEmptyOrWhitespace())!{
           msg = "Please enter city."
        }
        else if (txtCountry.text?.isEmptyOrWhitespace())! {
           msg = "Please enter country."
        }
      }
        isvalid =  msg == "" ? true : false
        return (isvalid,msg)
    }
    
}

//MARK:- ====== TextField Delegate =====
extension CreateEventInfoVC : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtAddress {
            let placePickerController = GMSAutocompleteViewController()
            placePickerController.delegate = self
            present(placePickerController, animated: true, completion: nil)
          }
        }
     }

  //MARK:- ======= PlacePicker =====
 extension CreateEventInfoVC : GMSAutocompleteViewControllerDelegate {
     
  // Handle the user's selection.
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    print("Place name: \(place.name)")
    print("Place address: \(place.formattedAddress)")
    print("Place attributions: \(place.attributions)")
    txtAddress.text = "\(place.formattedAddress ?? "")"
    dismiss(animated: true, completion: nil)
  }
     
  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
       // TODO: handle the error.
      print("Error: ", error.localizedDescription)
  }
     
  // User canceled the operation.
  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    dismiss(animated: true, completion: nil)
  }
     
  // Turn the network activity indicator on and off again.
  func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
     UIApplication.shared.isNetworkActivityIndicatorVisible = true
  }
     
  func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
      UIApplication.shared.isNetworkActivityIndicatorVisible = false
  }
}
