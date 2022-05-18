//
//  CreateEventVC.swift
//  MyEntry
//
//  Created by Kinjal Panchal on 18/10/21.
//

import UIKit

class CreateEventVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnActionMenu(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActionCreateEvent(_ sender: UIButton) {
        let vc = EventTypesVC.instantiate(appStoryboard: .main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
