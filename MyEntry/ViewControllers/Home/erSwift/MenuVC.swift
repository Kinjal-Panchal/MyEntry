//
//  MenuVC.swift
//  MyEntry
//
//  Created by panchal kinjal  on 11/09/21.
//

import UIKit
import SideMenuSwift
import SDWebImage

class Preferences {
    static let shared = Preferences()
    var enableTransitionAnimation = false
}

struct MenuData {
    var Title : String!
    var image : String!
}

class MenuCell : UITableViewCell {
    
    @IBOutlet weak var lblMenuTitle: ThemTitleLabel!
    @IBOutlet weak var imgMenu: UIImageView!
}

class MenuVC: UIViewController {

    //MARK:- ===== Outlets ====
    @IBOutlet weak var lblUserName: ThemTitleLabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var selectionMenuTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var tblMenu: UITableView!{
        didSet {
            tblMenu.dataSource = self
            tblMenu.delegate = self
            tblMenu.separatorStyle = .none
        }
    }
    
    
    //MARK:- ==== Variables ======
    var arrMenu = [MenuData(Title: "My Events", image: "ic_Event"),
                   MenuData(Title: "My Contacts", image: "ic_MyContact"),
                   MenuData(Title: "Subscriptions", image: "ic_Subscription"),
                   MenuData(Title: "Settings", image: "ic_Setting")]
    
    var selectedMenuClosure : (() -> ())?
    var isDarkModeEnabled = false
    var selectedMenuIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(NotificationKeys.kuserProfileKey.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(displayProfile), name: Notification.Name(NotificationKeys.kuserProfileKey.rawValue), object: nil)
        isDarkModeEnabled = SideMenuController.preferences.basic.position == .under
        configureView()
        sideMenuController?.delegate = self
        dataSetup()
        tblMenu.reloadData()

    }
    
    func dataSetup(){
        if Singleton.sharedInstance.UserProfilData?.image != "" {
           // imgProfile.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgProfile.sd_setImage(with: URL(string: Singleton.sharedInstance.UserProfilData?.image ?? ""), placeholderImage: UIImage(named: "account"))
        }
        else {
            imgProfile.image = UIImage(named: "account")
        }
        lblUserName.text = Singleton.sharedInstance.UserProfilData?.username
    }
    
    @objc func displayProfile(){
        dataSetup()
    }
    
    private func configureView() {
//        if isDarkModeEnabled {
//            themeColor = UIColor(red: 0.03, green: 0.04, blue: 0.07, alpha: 1.00)
//            selectionTableViewHeader.textColor = .white
//        } else {
//            selectionMenuTrailingConstraint.constant = 0
//            themeColor = UIColor(red: 0.98, green: 0.97, blue: 0.96, alpha: 1.00)
//        }
        
        let sidemenuBasicConfiguration = SideMenuController.preferences.basic
        let showPlaceTableOnLeft = (sidemenuBasicConfiguration.position == .under) != (sidemenuBasicConfiguration.direction == .right)
        if showPlaceTableOnLeft {
            // selectionMenuTrailingConstraint.constant = -(view.frame.width)
            selectionMenuTrailingConstraint.constant = SideMenuController.preferences.basic.menuWidth - view.frame.width
        }
        
        view.backgroundColor = .clear
        //tableView.backgroundColor = themeColor
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        let sideMenuBasicConfiguration = SideMenuController.preferences.basic
        let showPlaceTableOnLeft = (sideMenuBasicConfiguration.position == .under) != (sideMenuBasicConfiguration.direction == .right)
        selectionMenuTrailingConstraint.constant = showPlaceTableOnLeft ? SideMenuController.preferences.basic.menuWidth - size.width : 0
        view.layoutIfNeeded()
    }
    
    @objc func refreshMenu() {
        DispatchQueue.main.async { [self] in
            self.selectedMenuIndex = 0
            self.tblMenu.reloadData()
        }
    }
}
extension MenuVC: SideMenuControllerDelegate {
    func sideMenuController(_ sideMenuController: SideMenuController,
                            animationControllerFrom fromVC: UIViewController,
                            to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BasicTransitionAnimator(options: .transitionFlipFromLeft, duration: 0.6)
    }
    
    func sideMenuController(_ sideMenuController: SideMenuController, willShow viewController: UIViewController, animated: Bool) {
        print("[Example] View controller will show [\(viewController)]")
    }
    
    func sideMenuController(_ sideMenuController: SideMenuController, didShow viewController: UIViewController, animated: Bool) {
        print("[Example] View controller did show [\(viewController)]")
    }
    
    func sideMenuControllerWillHideMenu(_ sideMenuController: SideMenuController) {
        print("[Example] Menu will hide")
    }
    
    func sideMenuControllerDidHideMenu(_ sideMenuController: SideMenuController) {
        
        
        
        print("[Example] Menu did hide.")
        
    }
    
    func sideMenuControllerWillRevealMenu(_ sideMenuController: SideMenuController) {
        print("[Example] Menu will reveal.")
    }
    
    func sideMenuControllerDidRevealMenu(_ sideMenuController: SideMenuController) {
        print("[Example] Menu did reveal.")
    }
    
}

extension MenuVC : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.lblMenuTitle.text = arrMenu[indexPath.row].Title
        cell.imgMenu.image = UIImage(named: arrMenu[indexPath.row].image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedMenuIndex = 0
        tblMenu.reloadData()
        sideMenuController?.hideMenu()
        
        let homeVC = self.parent?.children.first?.children.first as? MyEventVC
        
        //let strCellItemTitle = mylblarr[indexPath.row]
        
        
        switch indexPath.row {
        case 0:
            let vc = MyEventVC.instantiate(appStoryboard: .main)
            homeVC?.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = MyContactVC.instantiate(appStoryboard: .main)
            homeVC?.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = SubScriptionVC.instantiate(appStoryboard: .main)
            homeVC?.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = SettingVC.instantiate(appStoryboard: .main)
            homeVC?.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}
