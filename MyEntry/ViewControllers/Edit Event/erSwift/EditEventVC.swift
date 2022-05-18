//
//  EditEventVC.swift
//  MyEntry
//
//  Created by panchal kinjal  on 03/10/21.
//

import UIKit
import SDWebImage

class EditEventVC: UIViewController {
    
    //MARK:- ===== Outlets =====
    @IBOutlet weak var tblEventTypes: UITableView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblEventTitle: ThemTitleLabel!
    
    //MARK:- ==== Variables ======
    var arrMenu = ["About","Additional settings","Event types"]
    var objEvent : EventData!

    //MARK:-==== View Controller Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSetup()
    }
    
    
    func dataSetup(){
        lblEventTitle.text = objEvent.eventTitle
        if Singleton.sharedInstance.UserProfilData?.image != "" {
           // imgProfile.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgProfile.sd_setImage(with: URL(string: Singleton.sharedInstance.UserProfilData?.image ?? ""), placeholderImage: UIImage(named: "account"))
        }
        else {
            imgProfile.image = UIImage(named: "account")
        }
    }
    
    
    //MARK:- ====== Back Btn Action ====
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}

extension EditEventVC : UITableViewDataSource , UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettigCell", for: indexPath) as! SettigCell
            cell.lblTitle.text = arrMenu[indexPath.row]
            return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0 :
            let eventInfoVc : CreateEventInfoVC = CreateEventInfoVC.instantiate(appStoryboard: .main)
            eventInfoVc.objEvent = objEvent
            self.navigationController?.pushViewController(eventInfoVc, animated: true)
        case 1 :
            let additonalSettingInfoVc : AdditionalSettingVC = AdditionalSettingVC.instantiate(appStoryboard: .main)
            additonalSettingInfoVc.objEvent = objEvent
            self.navigationController?.pushViewController(additonalSettingInfoVc, animated: true)
        case 2 :
            let eventTypeVC : EventTypesVC = EventTypesVC.instantiate(appStoryboard: .main)
            eventTypeVC.objEvent = objEvent
            self.navigationController?.pushViewController(eventTypeVC, animated: true)
        default:
            break
        }
    }
    
}
