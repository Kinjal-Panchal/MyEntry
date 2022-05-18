//
//  NotificationListVC.swift
//  MyEntry
//
//  Created by Kinjal panchal on 11/12/21.
//

import UIKit
import AVFoundation

class NotificationCell : UITableViewCell {
    
    //MARK:- ===== Outlets =====
    @IBOutlet weak var btnSwitch: UISwitch!
    @IBOutlet weak var lblTitle: ThemTitleLabel!
    
}

enum Notificationstatus : String {
    case on = "On"
    case off = "Off"
    
    func passStatus(Status:Bool) -> String{
        return Status == true ? Notificationstatus.on.rawValue : Notificationstatus.off.rawValue
    }
}

struct NotificationList {
    var headerTitle : String!
    var Subtitle : [NotificationData]!
    
}
struct NotificationData {
    var title : String?
    var status : String?
}

class NotificationListVC: UIViewController {

    //MARK:- ===== Outlets ======
    @IBOutlet weak var lblTitle: ThemTitleLabel!
    @IBOutlet weak var tblNotification: UITableView!
    
    
    var switchstatus : Notificationstatus = .off
    var isfromLink = false
    var arrLinkedAccount = [NotificationData(title: "Google", status:"0"),NotificationData(title: "Facebook", status: "0"),NotificationData(title: "Apple", status: "0")]
    var notificationTypes : NotificatioTypeData?
    var arrNotificationList = [NotificationList]()
    
    
    //MARK:- ===== ViewController LifeCycle ====
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !isfromLink {
            lblTitle.text = "Notifications"
            webServiceNotificationList()
        }
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btNActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension NotificationListVC : UITableViewDataSource , UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return isfromLink ? 1 : arrNotificationList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isfromLink ? arrLinkedAccount.count : arrNotificationList[section].Subtitle.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell") as! NotificationCell
        if isfromLink {
            cell.lblTitle.text = arrLinkedAccount[indexPath.row].title
        }
        else {
            cell.btnSwitch.isOn = arrNotificationList[indexPath.section].Subtitle[indexPath.row].status == "Off" ? false : true
            cell.lblTitle.text = arrNotificationList[indexPath.section].Subtitle[indexPath.row].title
            cell.btnSwitch.tag = indexPath.row
            cell.btnSwitch.addTarget(self, action: #selector(statusUpdate), for:.valueChanged)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if  !isfromLink {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
            headerView.backgroundColor = UIColor.clear
            //UIColor(red: 254/255, green: 248/255, blue: 248/255, alpha: 1)
            let label = UILabel()
            label.frame = CGRect.init(x: 30, y: 5, width: headerView.frame.width, height: headerView.frame.height)
        label.text = arrNotificationList[section].headerTitle
        label.font = CustomFont.Light.returnFont(FontSize.size14.rawValue)
        label.textColor = colors.ThemeGray.value
        headerView.addSubview(label)
         return headerView
        }
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return isfromLink ? 0 : 50
    }
    
    @objc func statusUpdate(mySwitch: UISwitch) {
            let value = mySwitch.isOn
            print("switch value changed \(value)")
        changeNotificationStatus(status: switchstatus.passStatus(Status: value), Type: arrNotificationList[mySwitch.tag].Subtitle[mySwitch.tag].title ?? "")
     }
    
    //MARK:- ===== Notification List ====
    func webServiceNotificationList(){
        LoaderClass.showActivityIndicator()
        let reqModel = CommonReqModel()
        reqModel.user_id = Singleton.sharedInstance.UserId ?? ""
        WebServiceSubClass.notificationList(reqModel: reqModel) { [self] status, message, response, error in
            LoaderClass.hideActivityIndicator()
            if status {
               print(response)
                self.notificationTypes = response?.data
                self.arrNotificationList = [NotificationList(headerTitle: "NOTIFICATION WHEN I AM A HOST", Subtitle: [NotificationData(title: "When guest RSVP", status: notificationTypes?.guestRsvp),NotificationData(title: "When i receive a message", status: notificationTypes?.iReceiveMessage),NotificationData(title: "when an invite is undelievered", status: notificationTypes?.whenAnInviteUndelivered)]),
                    NotificationList(headerTitle: "NOTIFICATION WHEN I AM AN INVITE", Subtitle: [NotificationData(title: "When i receive an invitation", status:notificationTypes?.whenIReceiveAnInvitation),NotificationData(title: "Reminder for the event", status:notificationTypes?.reminderEvent),NotificationData(title: "When i receive a message", status:notificationTypes?.iReceiveMessage)]),
                        NotificationList(headerTitle: "MARKETING", Subtitle: [NotificationData(title: "Marketing notifications", status: notificationTypes?.marketingNotification)])]
//                if response?.data?.count != 0 {
//                    self.arrNotificationList = response?.data ?? []
//                }
                self.tblNotification.reloadData()
             }
            else {
                AlertMessage.showMessageForError(message)
            }
        }
    }
    
    //MARK:- ====== Update Notification status ===
    func changeNotificationStatus(status:String , Type : String){
        LoaderClass.showActivityIndicator()
        let reqModel = NotificationRequestModel()
        reqModel.notification = Type
        reqModel.user_id = Singleton.sharedInstance.UserId
        reqModel.status = status
        WebServiceSubClass.notificationStatusUpdate(reqModel: reqModel) { status, message, response, error in
            LoaderClass.hideActivityIndicator()
            if status {
                print(response)
                AlertMessage.showMessageForSuccess(response?.message ?? "")
            }
            else{
                AlertMessage.showMessageForError(message)
            }
        }
    }
}



