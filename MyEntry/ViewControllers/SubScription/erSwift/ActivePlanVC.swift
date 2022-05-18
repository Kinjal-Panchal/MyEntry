//
//  ActivePlanVC.swift
//  MyEntry
//
//  Created by panchal kinjal  on 15/10/21.
//

import UIKit
import UPCarouselFlowLayout


class ActivePlanVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- ===== Btn Action Menu ====
    @IBAction func btnActionMenu(_ sender: UIButton) {
        sideMenuController?.revealMenu()
    }
    
    
    //MARK:- ===== Btn Action Upgrade ====
    @IBAction func btnActionUpgrade(_ sender: UIButton) {
        
        let planVC = SubScriptionPlanVC.instantiate(appStoryboard: .main)
        self.navigationController?.pushViewController(planVC, animated: true)
    }
    
    
    //MARK:- ===== Btn Action Cancel ====
    @IBAction func btnActionCancel(_ sender: UIButton) {
    }
    
    
}

