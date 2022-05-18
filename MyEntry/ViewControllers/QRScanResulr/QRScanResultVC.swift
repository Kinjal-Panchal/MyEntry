//
//  QRScanResultVC.swift
//  MyEntry
//
//  Created by Kinjal panchal on 25/04/22.
//

import UIKit

class QRScanResultVC: UIViewController {

    //MARK:- ===== Outlets =====
    @IBOutlet weak var lblDate: ThemTitleLabel!
    @IBOutlet weak var lblTime: ThemTitleLabel!
    @IBOutlet weak var lblPlace: ThemTitleLabel!
    @IBOutlet weak var lblHosted: ThemTitleLabel!
    @IBOutlet weak var imgEventType: UIImageView!
    @IBOutlet weak var lblEventName: ThemTitleLabel!
    
    @IBOutlet weak var lblName: ThemTitleLabel!
    
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var lblEmail: ThemTitleLabel!
    
    @IBOutlet weak var lblPlaces: UILabel!
    @IBOutlet weak var lblTicketType: UILabel!
    @IBOutlet weak var lblSeat: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    //MARK:- ====== Btn Action Approve =====
    @IBAction func btnActionApprove(_ sender: UIButton) {
    }
    
}
