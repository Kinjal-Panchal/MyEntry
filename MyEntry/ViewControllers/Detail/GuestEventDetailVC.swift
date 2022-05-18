//
//  GuestEventDetailVC.swift
//  MyEntry
//
//  Created by Kinjal panchal on 05/02/22.
//

import UIKit

//Confirm, Unconfirm
enum eventStatus : String{
    case confirm = "Confirm"
    case unConfirm = "Unconfirm"
}

//MARK: ===== Event Details =====
class GuestEventDetailVC: UIViewController {

    //MARK: ===== Outlets =====
    @IBOutlet weak var vwCalender: UIView!
    @IBOutlet weak var vwWallet: UIView!
    @IBOutlet weak var vwNotAttend: UIView!
    @IBOutlet weak var vwAttend: UIView!
    @IBOutlet weak var lblTitle: ThemTitleLabel!
    @IBOutlet weak var lblHosted: ThemTitleLabel!
    @IBOutlet weak var lblGuests: ThemTitleLabel!
    @IBOutlet weak var lblEventTitle: ThemTitleLabel!
    @IBOutlet weak var lblTime: ThemTitleLabel!
    @IBOutlet weak var lblVenue: ThemTitleLabel!
    @IBOutlet weak var lblDate: ThemTitleLabel!
    @IBOutlet weak var imgTemplate: UIImageView!
    @IBOutlet weak var imgIcon: UIImageView!
    
    
    //MARK: ====== Variables ======
    var obj : EventData?
    var isFromDetail = false

    
    //MARK: ====== ViewController Life Cycle =======
    override func viewDidLoad() {
        super.viewDidLoad()
        DataSetup()
        vwCalender.isHidden = isFromDetail
        vwWallet.isHidden = isFromDetail
        vwAttend.isHidden = !isFromDetail
        vwNotAttend.isHidden = !isFromDetail
        //vwWallet.isHidden = true
        //vwCalender.isHidden = true
        //vwsetup()
    }
    
    
    //MARK: ====== Back Btn Action ======
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: ==== View Setup ===
    func vwsetup(){
        vwNotAttend.borderWidth = 1
        vwCalender.borderWidth = 1
        vwNotAttend.borderWidth = 1
        vwAttend.borderWidth = 1
        vwAttend.borderColor = UIColor.hexStringToUIColor(hex: "#C4C4C4")
        vwNotAttend.borderColor = UIColor.hexStringToUIColor(hex: "#C4C4C4")
        vwWallet.borderColor = UIColor.hexStringToUIColor(hex: "#C4C4C4")
        vwCalender.borderColor = UIColor.hexStringToUIColor(hex: "#C4C4C4")
    }
    
    
    //MARK: - DataSetup ====
    func DataSetup(){
        lblTitle.text = obj?.eventTitle
        lblDate.text = UtilityClass.getDateString(dateString: obj?.eventDate ?? "2021-12-09")
        lblTime.text = obj?.allDayEvent == "yes" ? "full day" : obj?.eventTime //"\(obj?.startTime ?? "")-\(obj?.endTime ?? "")"
        lblVenue.text = obj?.address
        lblEventTitle.text = obj?.eventTitle
        lblHosted.text = "Hosted by \(obj?.hostName ?? "")"
        lblGuests.text = "\(obj?.totalGuest ?? 0)\nGuests"
       // cell.imgTemplate.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imgTemplate.sd_setImage(with: URL(string: obj?.templateImage ?? ""), placeholderImage: UIImage(named: "account"))
        imgIcon.sd_setImage(with: URL(string: obj?.eventIcon ?? ""), placeholderImage: UIImage(named: "account"))
    }

    
    //MARK: ====== Add To Calander button Action ======
    @IBAction func btnActionAddToCalender(_ sender: UIButton) {
        //EventHelper.shared.StartDate =
        //EventHelper.shared.isfullDay = obj?.allDayEvent
        EventHelper.shared.generateEvent(Title:obj?.eventTitle ?? "", Notes:"" )
    }
    
    
    //MARK: ====== Add To Wallet button Action ======
    @IBAction func btnActionAddToWallet(_ sender: UIButton) {
        
    }

    //MARK: ====== Attend button Action ======
    @IBAction func btnActionAttend(_ sender: UIButton) {
        webServiceCallAttendEvent(status: eventStatus.confirm.rawValue)
    }
    
    
    //MARK: ====== Not Attend button Action ======
    @IBAction func btnActionWillNotAttend(_ sender: UIButton) {
        webServiceCallAttendEvent(status: eventStatus.unConfirm.rawValue)
    }
    
}

extension GuestEventDetailVC {
    
    //MARK: === Webservice call Attend Event ======
    func webServiceCallAttendEvent(status:String){
        let reqModel = AttendEventReqstModel()
        reqModel.event_id = "\(obj?.id ?? 0)"
        reqModel.user_id = Singleton.sharedInstance.UserId
        reqModel.status = status
        WebServiceSubClass.AttendEvent(reqModel: reqModel) { Status, message, response, error in
            if Status {
                print(response)
                if status == "Confirm" {
                    self.vwAttend.isHidden = true
                    self.vwNotAttend.isHidden = true
                    self.vwCalender.isHidden = false
                    self.vwWallet.isHidden = false
                }
                else {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            else {
                AlertMessage.showMessageForError(message)
            }
        }
    }
}
