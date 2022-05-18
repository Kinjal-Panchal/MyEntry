//
//  ReferaFriendVC.swift
//  MyEntry
//
//  Created by panchal kinjal  on 11/09/21.
//

import UIKit
import SDWebImage

class ReferaFriendVC: UIViewController {

    //MARK:- ==== Outlets ===
    @IBOutlet weak var imgProfile: UIImageView!
    
    
    //MARK:- ====== Outlets ======
    let NodataFoundView = Bundle.main.loadNibNamed("NavigationView", owner: nil, options: nil)?.first as? NavigationView
    
    
    //MARK:- ====== View Controller Life cycle =====
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSetup()
       // self.navigationItem.titleView = NodataFoundView
    }
    
    //MARK:- ==== Btn Action Back ====
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func goBack()
    {
       self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK:- ==== DataSetup ====
    func dataSetup(){
        if Singleton.sharedInstance.UserProfilData?.image != "" {
           // imgProfile.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgProfile.sd_setImage(with: URL(string: Singleton.sharedInstance.UserProfilData?.image ?? ""), placeholderImage: UIImage(named: "account"))
        }
        else {
            imgProfile.image = UIImage(named: "account")
        }
    }
}
