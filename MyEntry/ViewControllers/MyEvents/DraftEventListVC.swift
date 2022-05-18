//
//  DraftEventListVC.swift
//  MyEntry
//
//  Created by Kinjal panchal on 28/11/21.
//

import UIKit
import SDWebImage

class EventHistoryCell : UITableViewCell {
    
    //MARK:- ===== Outlets =====
    @IBOutlet weak var lblGuests: ThemTitleLabel!
    @IBOutlet weak var lblEventTitle: ThemTitleLabel!
    @IBOutlet weak var lblDate: ThemTitleLabel!
    @IBOutlet weak var lblTime: ThemTitleLabel!
    @IBOutlet weak var lblVenue: ThemTitleLabel!
    @IBOutlet weak var lblHostedBy: ThemTitleLabel!
    @IBOutlet weak var iconEvent: UIImageView!
    @IBOutlet weak var imgTemplate: UIImageView!
    
    var deleteEvent:(()->())?
    var editEvent:(()->())?
    
    //MARK:- ==== Btn Action Cancel =====
    @IBAction func btnActionCancel(_ sender: UIButton) {
        if let clicked = deleteEvent {
            clicked()
        }
    }
    
    
    //MARK:- ==== Btn Action Detail =====
    @IBAction func btnActionDetail(_ sender: UIButton) {
        if let clicked = editEvent {
            clicked()
        }
    }
    
}

class DraftEventListVC: UIViewController {

    //MARK:- ==== Outlets ====
    @IBOutlet weak var noEvents: ThemeRoundPinkBGView!
    @IBOutlet weak var tblEventList: UITableView!
    
    //MARK:- ==== Variables =====
    var arrEventList = [EventData]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(NotificationKeys.kUpdateEventList.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateList), name: Notification.Name(NotificationKeys.kUpdateEventList.rawValue), object: nil)
        webserviceCallEventList()
    }
    
    @objc func updateList(){
        webserviceCallEventList()
    }
    
}

//MARK:-==== WebserviceCall Eventlist
extension DraftEventListVC {
    
    //MARK:- ===== WebService Call Event List ====
    func webserviceCallEventList(){
        LoaderClass.showActivityIndicator()
        let reqModel = EventListReqModel()
        reqModel.user_id = "\(Singleton.sharedInstance.UserProfilData?.id ?? 0)"
        reqModel.type = "draft"
        
        WebServiceSubClass.EventListType(eventReqModel: reqModel) { status, message, response, error in
            LoaderClass.hideActivityIndicator()
            if status {
                print(response)
                if response?.data?.count != 0 {

                    guard let events = response?.data else { return }
                    self.arrEventList = events
                    self.noEvents.isHidden = true
                    DispatchQueue.main.async {
                        self.tblEventList.reloadData()
                    }
                }
                else {
                    self.arrEventList.removeAll()
                   // self.tblEventList.isHidden = true
                    self.noEvents.isHidden = false
                }
            }
            else {
                
            }
          }
        }
}
//MARK:- =======  Tableview DataSource and Delegate ======
extension DraftEventListVC : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrEventList.count != 0 ? arrEventList.count : 0
      }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventHistoryCell", for: indexPath) as! EventHistoryCell
        let obj = arrEventList[indexPath.row]
        cell.lblDate.text = UtilityClass.getDateString(dateString: obj.eventDate ?? "2021-12-09")
    
        cell.lblTime.text = obj.allDayEvent == "yes" ? "full day" :  "\(obj.startTime ?? "")-\(obj.endTime ?? "")"
        cell.lblVenue.text = obj.address
        cell.lblEventTitle.text = obj.eventTitle
        cell.lblHostedBy.text = "Hosted by \(obj.hostName ?? "")"
        cell.lblGuests.text = "\(obj.totalGuest ?? 0)\nGuests"
       // cell.imgTemplate.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.imgTemplate.sd_setImage(with: URL(string: obj.templateImage ?? ""), placeholderImage: UIImage(named: "account"))
        cell.iconEvent.sd_setImage(with: URL(string: obj.eventIcon ?? ""), placeholderImage: UIImage(named: "account"))
        cell.deleteEvent = {
            self.webServiceCallDeleteEvent(eventId: "\(obj.id ?? 0)")
        }
        cell.editEvent = {
            let editEventVc : EditEventVC = EditEventVC.instantiate(appStoryboard: .main)
            editEventVc.objEvent = obj
            self.navigationController?.pushViewController(editEventVc, animated: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //MARK:- ====== Remove Event =====
    func webServiceCallDeleteEvent(eventId:String){
        LoaderClass.showActivityIndicator()
        let reqModel = EventRemoveReqModel()
        reqModel.id = eventId
        WebServiceSubClass.removeEvent(reqModel: reqModel) { status, message, response, error in
            LoaderClass.hideActivityIndicator()
            if status {
                print(response)
                AlertMessage.showMessageForSuccess(response?.message ?? "")
                self.webserviceCallEventList()
            }
            else{
                AlertMessage.showMessageForError(message)
            }
        }
    }
}
