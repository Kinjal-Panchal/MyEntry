//
//  SettingVC.swift
//  MyEntry
//
//  Created by panchal kinjal  on 11/09/21.
//

import UIKit
import SDWebImage

class settingData {
    var headerTitle : String!
    var Subtitle : [String]!
    
    init(Title:String,SubTitle:[String]) {
        self.headerTitle = Title
        self.Subtitle = SubTitle
    }
}

class SettigCell : UITableViewCell {
    
    @IBOutlet weak var lblTitle: ThemTitleLabel!
}

class logoutCell : UITableViewCell {
    
}

//MARK:- === Setting VC ======
class SettingVC: UIViewController {

    //MARK:- ==== Outlets ====
    @IBOutlet weak var tblSetting: UITableView!
    @IBOutlet weak var imgProfile: UIImageView!
    
    
    //MARK:- === SettingData ====
    var arrSetting = [settingData(Title: "Account Settings", SubTitle: ["Edit Profile","Notifications","linked Accounts"]),
                      settingData(Title: "Privacy and Security", SubTitle: ["Change Password","Privacy Policy" , "Terms of Use"]),
                      settingData(Title: "Help and Support", SubTitle: ["FAQ","Refer a Friend","Log out"])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(NotificationKeys.kuserProfileKey.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(displayProfile), name: Notification.Name(NotificationKeys.kuserProfileKey.rawValue), object: nil)
        dataSetup()
        self.navigationController?.navigationBar.isHidden = true
        tblSetting.reloadData()
    }
    
    func dataSetup(){
        if Singleton.sharedInstance.UserProfilData?.image != "" {
            //imgProfile.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgProfile.sd_setImage(with: URL(string: Singleton.sharedInstance.UserProfilData?.image ?? ""), placeholderImage: UIImage(named: "account"))
          }
         else {
            imgProfile.image = UIImage(named: "account")
        }
    }
    
    @objc func displayProfile(){
        dataSetup()
    }

    //MARK:- ====== Menu btn Action =====
    @IBAction func btnActionMenu(_ sender: UIButton) {
     //let controller = sender?.layer.value(forKey: "controller") as?       UIViewController
        self.sideMenuController?.revealMenu()
    }
}
extension SettingVC : UITableViewDataSource , UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrSetting.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSetting[section].Subtitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if arrSetting[indexPath.section].Subtitle[indexPath.row] == "Log out"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "logoutCell", for: indexPath) as! logoutCell
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettigCell", for: indexPath) as! SettigCell
            cell.lblTitle.text = arrSetting[indexPath.section].Subtitle[indexPath.row]
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = UIColor(red: 254/255, green: 248/255, blue: 248/255, alpha: 1)
            let label = UILabel()
            label.frame = CGRect.init(x: 30, y: 5, width: headerView.frame.width, height: headerView.frame.height)
        label.text = arrSetting[section].headerTitle
        label.font = CustomFont.Light.returnFont(FontSize.size14.rawValue)
        label.textColor = colors.ThemeGray.value
        headerView.addSubview(label)
         return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if arrSetting[indexPath.section].Subtitle[indexPath.row] == "Refer a Friend" {
            let referVC = ReferaFriendVC.instantiate(appStoryboard: .main)
            self.navigationController?.pushViewController(referVC, animated: true)
        }
        else if arrSetting[indexPath.section].Subtitle[indexPath.row] == "Edit Profile" {
            let editProfileVC = UpdateProfileVC.instantiate(appStoryboard: .main)
            self.navigationController?.pushViewController(editProfileVC, animated: true)
        }
        else if arrSetting[indexPath.section].Subtitle[indexPath.row] == "Change Password" {
            let  changePasswordVC = ChangePasswordVC.instantiate(appStoryboard: .main)
            self.navigationController?.pushViewController(changePasswordVC, animated: true)
        }
        else if arrSetting[indexPath.section].Subtitle[indexPath.row] == "Notifications"{
            let notificationVC = NotificationListVC.instantiate(appStoryboard: .main)
            self.navigationController?.pushViewController(notificationVC, animated: true)
        }
        else if arrSetting[indexPath.section].Subtitle[indexPath.row] == "linked Accounts" {
            let notificationVC : NotificationListVC = NotificationListVC.instantiate(appStoryboard: .main)
            notificationVC.isfromLink = true
            self.navigationController?.pushViewController(notificationVC, animated: true)
        }
        else if arrSetting[indexPath.section].Subtitle[indexPath.row] == "Log out"{
                 let alert = UIAlertController(title: Constant.AppName, message: "Are you sure want to logout?", preferredStyle: UIAlertController.Style.alert)

                 alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                     Appdel.dologout()
                   }))
                   
                    alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil))
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
               }
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if arrSetting[indexPath.section].Subtitle[indexPath.row] == "Log out" {
            return 80
        }
        return 55
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
