//
//  MessageDeliveryVC.swift
//  MyEntry
//
//  Created by Kinjal panchal on 27/02/22.
//

import UIKit

struct MessageList {
    var headerTitle : String!
    var Subtitle : [MessageData]!
    
}
struct MessageData {
    var title : String?
    var Count: String
}

class MessageDelieveryCell : UITableViewCell {
    
    @IBOutlet weak var lblNo: ThemTitleLabel!
    @IBOutlet weak var lblTitle: ThemTitleLabel!
}


class MessageDeliveryVC: UIViewController {
    
    //MARK:- ==== Outlets ===
    @IBOutlet weak var lblTotalReceiptionNo: ThemTitleLabel!
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var lblHeaderTitle: ThemTitleLabel!
    @IBOutlet weak var lblDateTime: ThemTitleLabel!
    @IBOutlet weak var lblEventName: ThemTitleLabel!
    
    var objEvent : EventdetailData?
    var arrMessage = [MessageList(headerTitle: "", Subtitle: [MessageData(title: "Opened", Count: "0"),MessageData(title: "Clicked", Count: "0"),MessageData(title: "Unopened", Count: "0")]),
                      MessageList(headerTitle: "RSVP Report", Subtitle: [MessageData(title: "Confirmed", Count: "0"),MessageData(title: "Waiting List", Count: "0")])]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataSetup()
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - DataSetup ====
    func DataSetup(){
        let strDate = UtilityClass.DateStringChange(Format:StrdateFormatter.StrYMD.rawValue, getFormat: StrdateFormatter.strDMY.rawValue, dateString: objEvent?.eventDate ?? "")
         if objEvent?.allDayEvent == "yes" {
            lblDateTime.text = strDate
         }
         else {
            lblDateTime.text = "\(strDate) at \(objEvent?.startTime ?? "")"
         }
        lblTotalReceiptionNo.text = "\(objEvent?.totalGuest ?? 0)"
         lblEventName.text = objEvent?.eventTitle
    }
}


extension MessageDeliveryVC : UITableViewDataSource , UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrMessage.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMessage[section].Subtitle.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageDelieveryCell") as! MessageDelieveryCell
        cell.lblTitle.text = arrMessage[indexPath.section].Subtitle[indexPath.row].title
        cell.lblNo.text = arrMessage[indexPath.section].Subtitle[indexPath.row].Count
        
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
            headerView.backgroundColor = UIColor.clear
            //UIColor(red: 254/255, green: 248/255, blue: 248/255, alpha: 1)
            let label = UILabel()
            label.frame = CGRect.init(x: 30, y: 0, width: headerView.frame.width, height: headerView.frame.height)
        label.text = arrMessage[section].headerTitle
        label.font = CustomFont.SemiBold.returnFont(FontSize.size18.rawValue)
        label.textColor = colors.ThemeGray.value
        label.backgroundColor = UIColor.clear
        headerView.addSubview(label)
         return headerView
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if arrMessage[indexPath.section].Subtitle[indexPath.row].title == "Waiting List" {
            let waitingListVC : WaitingListVC = WaitingListVC.instantiate(appStoryboard: .main)
            waitingListVC.objEvent = objEvent
            self.navigationController?.pushViewController(waitingListVC, animated: true)
        }
    }
}
