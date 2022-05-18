//
//  WelComeVC.swift
//  MyEntry
//
//  Created by panchal kinjal  on 11/09/21.
//

import UIKit

class WelComeVC: UIViewController {

    //MARK:- ===== Outlets ====
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK:- === BTn Action ===
    @IBAction func btnActionGettingStarted(_ sender: UIButton) {
        appDel.navigateToHome()
    }
    

}
