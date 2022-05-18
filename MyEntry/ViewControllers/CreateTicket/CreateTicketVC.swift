//
//  CreateTicketVC.swift
//  MyEntry
//
//  Created by Kinjal panchal on 06/11/21.
//

import UIKit

class CreateTicketVC: UIViewController {

    //MARK: - ===== Outlets ====
    @IBOutlet weak var ticketTitle: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var switchSeatAllocation: UISwitch!
    @IBOutlet weak var switchAddToCalender: UISwitch!
    @IBOutlet weak var txtQuantity: UITextField!
    @IBOutlet weak var txtMaximumPerson: UITextField!
    @IBOutlet weak var txtOnSaleUntil: UITextField!
    @IBOutlet weak var txtPricePerTicket: UITextField!
    @IBOutlet weak var viewSeatAllocation: UIView!
    @IBOutlet weak var txtAllowed: UITextField!
    @IBOutlet weak var txtType: UITextField!
    @IBOutlet weak var vwAllowed: UIView!
    @IBOutlet weak var vwmaximumTicket: UIView!
    
    
    let datePickerView:UIDatePicker = UIDatePicker()
    let ticketTypesPickerView  = UIPickerView()
    var arrTicketTypes = ["Public" , "VIP"]
    var eventId = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePickerView.datePickerMode = .dateAndTime
        if #available(iOS 13.4, *) {
            datePickerView.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        txtOnSaleUntil.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: UIControl.Event.valueChanged)
        ticketTypesPickerView.dataSource = self
        ticketTypesPickerView.delegate = self
        txtType.inputView = ticketTypesPickerView
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActionCreateTicket(_ sender: UIButton) {
        let validator = validation()
        if validator.0 == false {
            AlertMessage.showMessageForError(validator.1)
        }
        else{
            webServiceCallCreateTicket()
        }
    }
    
    func validation() -> (Bool,String) {
         var msg = ""
         var status = true
        
        if (ticketTitle.text?.isEmptyOrWhitespace())! {
            msg = "Please enter ticket title"
        }
        else if (txtDescription.text?.isEmptyOrWhitespace())! {
            msg = "Please enter description"
        }
        else if (txtType.text?.isEmptyOrWhitespace())! {
            msg = "Please select tickettype"
        }
        else if (txtPricePerTicket.text?.isEmptyOrWhitespace())! {
            msg = "Please enter ticket price"
        }
        else if (txtOnSaleUntil.text?.isEmptyOrWhitespace())! {
            msg = "Please select on sale until"
        }
        status = msg == "" ? true : false
        return (status , msg)
    }
}


extension CreateTicketVC : UIPickerViewDataSource , UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrTicketTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrTicketTypes[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtType.text = arrTicketTypes[row]
        if arrTicketTypes[row] == "Public" {
            txtQuantity.textColor = UIColor.gray
            txtQuantity.isUserInteractionEnabled = false
            txtQuantity.text = "Unlimited"
            txtPricePerTicket.text = "Regular"
            txtPricePerTicket.isUserInteractionEnabled = false
            txtMaximumPerson.text = "1"
            txtMaximumPerson.isUserInteractionEnabled = false
            viewSeatAllocation.isHidden = true
            vwAllowed.isHidden = true
            vwmaximumTicket.isHidden = false
        }
        else {
            txtAllowed.isUserInteractionEnabled = false
            txtQuantity.textColor = colors.ThemeGray.value
            txtQuantity.isUserInteractionEnabled = false
            txtQuantity.text = "1"
            txtPricePerTicket.text = ""
            txtPricePerTicket.isUserInteractionEnabled = true
            txtMaximumPerson.text = ""
            txtMaximumPerson.isUserInteractionEnabled = false
            viewSeatAllocation.isHidden = false
            vwAllowed.isHidden = false
            vwmaximumTicket.isHidden = true
        }
    }
    
    //MARK:- ==== Btn Action value Changed ======
    @objc func datePickerValueChanged(sender:UIDatePicker) {
         let dateFormatter = DateFormatter()
        // dateFormatter.dateStyle = DateFormatter.Style.medium
         dateFormatter.timeStyle = DateFormatter.Style.medium
         dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
         datePickerView.minimumDate = Calendar.current.date(byAdding:.day, value: 1, to: Date())
         txtOnSaleUntil.text = dateFormatter.string(from: sender.date)
     }
}

extension CreateTicketVC {
    
    func webServiceCallCreateTicket(){
        let reqModel = CreateTicketRequestModel()
        reqModel.event_id = eventId
        reqModel.user_id = Singleton.sharedInstance.UserId
        reqModel.ticket_title = ticketTitle.text ?? ""
        reqModel.description = txtDescription.text ?? ""
        reqModel.type = txtType.text ?? ""
        reqModel.price = txtPricePerTicket.text ?? ""
        reqModel.quantity = txtQuantity.text ?? ""
        reqModel.price_per_ticket = txtPricePerTicket.text ?? ""
        reqModel.add_to_calendar = switchAddToCalender.isOn == true ? "yes" : "no"
        if viewSeatAllocation.isHidden == false {
            reqModel.seat_allocation = switchSeatAllocation.isOn == true ? "yes" : "no"
        }
        else {
            reqModel.seat_allocation = "no"
        }
        reqModel.maximum_ticket_per_person = txtMaximumPerson.text ?? ""
        reqModel.on_sale_until = txtOnSaleUntil.text ?? ""
        reqModel.allowed = txtType.text == "VIP" ? "yes" : "no"
        
        WebServiceSubClass.createTicket(reqModel: reqModel) { status, message, response, error in
            if status {
                print(response)
                AlertMessage.showMessageForSuccess(response?.message ?? "")
            }
            else {
                AlertMessage.showMessageForError(message)
            }
        }
    }
}
