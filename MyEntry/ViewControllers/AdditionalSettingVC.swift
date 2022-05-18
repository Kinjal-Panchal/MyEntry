//
//  AdditionalSettingVC.swift
//  MyEntry
//
//  Created by Kinjal Panchal on 24/10/21.
//

import UIKit



class AdditionalSettingVC: UIViewController {

    //MARK:- ===== Outlets =======
    @IBOutlet weak var switchGuestList: UISwitch!
    @IBOutlet weak var switchallowedChildren: UISwitch!
    @IBOutlet weak var lblSendReminder: ThemTitleLabel!
    @IBOutlet weak var lblAllowedPerson: ThemTitleLabel!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var lblTitle: ThemTitleLabel!
    @IBOutlet weak var viewContinue: UIView!
    
    
    //MARK:- ==== Variables ======
    var allowed = 1
    var reminderdays = 1
    var createEventrequestModel = CreateEventReqModel()
    var objEvent : EventData!

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSetup()
        btnSave.setTitle("Save", for: .normal)
        btnSave.titleLabel?.font = CustomFont.Medium.returnFont(15.0)
        btnSave.setTitleColor(colors.ThemeGray.value, for: .normal)
        switchGuestList.addTarget(self, action: #selector(showguestList), for:.valueChanged)
        switchallowedChildren.addTarget(self, action: #selector(allowedChildren), for:.valueChanged)
    }
    
     func dataSetup(){
        if objEvent != nil {
            viewContinue.isHidden = true
            btnSave.isHidden = false
            lblTitle.text = "Edit Event"
            switchallowedChildren.isOn = objEvent.allowedChildren == "yes" ? true : false
            switchGuestList.isOn = objEvent.showGuestList == "yes" ? true : false
            lblSendReminder.text = "\(objEvent.sendReminder) day"
            lblAllowedPerson.text = objEvent.totalAllowed
        }
        else {
            viewContinue.isHidden = false
            btnSave.isHidden = true
        }
    }
    
    @objc func showguestList(mySwitch: UISwitch) {
            let value = mySwitch.isOn
            print("switch value changed \(value)")
    }
    
    @objc func allowedChildren(mySwitch: UISwitch) {
            let value = mySwitch.isOn
            print("switch value changed \(value)")
     }

    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActionContinue(_ sender: UIButton) {
        createEventrequestModel.send_reminder = "\(reminderdays)" //lblSendReminder.text
        createEventrequestModel.total_allowed = lblAllowedPerson.text
        createEventrequestModel.show_guest_list = switchGuestList.isOn == true ? "yes" : "no"
        createEventrequestModel.allowed_children = switchallowedChildren.isOn == true ? "yes" : "no"
        let vc:AddGuestVC = AddGuestVC.instantiate(appStoryboard: .main)
        vc.createEventrequestModel = createEventrequestModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnActionPlusReminder(_ sender: UIButton) {
        if reminderdays != 10 {
            reminderdays += 1
            lblSendReminder.text = "\(reminderdays) day"
        }
    }
    
    @IBAction func btnActionDownReminder(_ sender: Any) {
        if reminderdays != 0{
            reminderdays -= 1
            lblSendReminder.text = "\(reminderdays) day"
            
        }
    }
    
    @IBAction func btnActionMinusAllowed(_ sender: UIButton) {
        if allowed != 0 {
            allowed -= 1
            lblAllowedPerson.text = "\(allowed)"
        }
    }
    
    @IBAction func btnActionUpAllowed(_ sender: UIButton) {
        if allowed != 10 {
            allowed += 1
            lblAllowedPerson.text = "\(allowed)"
        }
    }
}
