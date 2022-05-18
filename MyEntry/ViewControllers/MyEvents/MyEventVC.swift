//
//  MyEventVC.swift
//  MyEntry
//
//  Created by Kinjal Panchal on 19/10/21.
//

import UIKit
import SDWebImage

class MyEventVC: UIViewController {

    //MARK:- ===== Outlets ======
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var lblTitle: ThemTitleLabel!
    @IBOutlet weak var EventListView: ThemeRoundPinkBGView!
    @IBOutlet weak var btnUpComing: UIButton!
    @IBOutlet weak var btnDrafts: UIButton!
    
    
    //MARK:- ==== View Controller Life cycle =====
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(NotificationKeys.kuserProfileKey.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(displayProfile), name: Notification.Name(NotificationKeys.kuserProfileKey.rawValue), object: nil)
         dataSetup()
      }
    
    func dataSetup(){
        if Singleton.sharedInstance.UserProfilData?.image != "" {
           // imgProfile.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgProfile.sd_setImage(with: URL(string: Singleton.sharedInstance.UserProfilData?.image ?? ""), placeholderImage: UIImage(named: "account"))
        }
        else {
            imgProfile.image = UIImage(named: "account")
        }
        btnSelected(SelectedBtn: btnUpComing, UnSelected: btnDrafts)
        scrollview.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    @objc func displayProfile(){
        if Singleton.sharedInstance.UserProfilData?.image != "" {
           // imgProfile.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgProfile.sd_setImage(with: URL(string: Singleton.sharedInstance.UserProfilData?.image ?? ""), placeholderImage: UIImage(named: "account"))
        }
        else {
            imgProfile.image = UIImage(named: "account")
        }
    }
    
    //MARK:- ======= Btn Action Menu ======
    @IBAction func btnActionMenu(_ sender: UIButton) {
        sideMenuController?.revealMenu()
    }
    
    //MARK:- ======= Btn Action Event ======
    @IBAction func btnActionNewEvent(_ sender: UIButton) {
        let createEventVC = CreateEventVC.instantiate(appStoryboard: .main)
        self.navigationController?.pushViewController(createEventVC, animated: true)
    }
    
    @IBAction func btnActionUpComing(_ sender: UIButton) {
        btnSelected(SelectedBtn: btnUpComing, UnSelected: btnDrafts)
        scrollview.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    @IBAction func btnActionDraft(_ sender: UIButton) {
        btnSelected(SelectedBtn: btnDrafts, UnSelected: btnUpComing)
        scrollview.setContentOffset(CGPoint(x: self.view.frame.width, y: 0), animated: true)
     }
    
    func btnSelected(SelectedBtn:UIButton,UnSelected:UIButton) {
        SelectedBtn.isSelected = true
        SelectedBtn.titleLabel?.font = CustomFont.SemiBold.returnFont(FontSize.size16.rawValue)
        SelectedBtn.setTitleColor(colors.ThemeGray.value, for: .normal)
        UnSelected.isSelected = !SelectedBtn.isSelected
        UnSelected.titleLabel?.font = CustomFont.Medium.returnFont(FontSize.size15.rawValue)
        UnSelected.setTitleColor(colors.ThemeGray.value, for: .normal)
    }
    
    //MARK:- ======= Btn Action Add Event ======
    @IBAction func btnActionAddEvent(_ sender: UIButton) {
        let vc = EventTypesVC.instantiate(appStoryboard: .main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}



