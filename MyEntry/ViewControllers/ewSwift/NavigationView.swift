//
//  NavigationView.swift
//  MyEntry
//
//  Created by panchal kinjal  on 12/09/21.
//

import UIKit

class NavigationView: UIView {

    
    @IBAction func btnActionMenu(_ sender: UIButton) {
        
        let controller = sender.layer.value(forKey: "controller") as? UIViewController
        controller?.sideMenuController?.revealMenu()
        
    }
    
    
}
