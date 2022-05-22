//
//  OTPVerificationVC.swift
//  MyEntry
//
//  Created by panchal kinjal  on 10/09/21.
//

import UIKit

class OTPVerificationVC: UIViewController {

    //MARK:- ===== Variables ====
    var strName = String()
    
    
    //MARK:- ===== Outlets ====
    @IBOutlet weak var lblTitle: ThemTitleLabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblTitle.text = "\(Singleton.sharedInstance.UserProfilData?.username ?? "") You have successfully verified the account!"
    }
    
    
    //MARK:- ==== Btn Action Verification ===
    @IBAction func btnActionVerification(_ sender: UIButton) {
        
        let welcomeVC = WelComeVC.instantiate(appStoryboard: .Auth)
        self.navigationController?.pushViewController(welcomeVC, animated: true)
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
