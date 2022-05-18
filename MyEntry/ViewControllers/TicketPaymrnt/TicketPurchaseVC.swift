//
//  TicketPurchaseVC.swift
//  MyEntry
//
//  Created by Kinjal panchal on 24/04/22.
//

import UIKit

class TicketPurchaseVC: UIViewController {

    //MARK:- ===== Outlets ======
    @IBOutlet weak var lblSeats: ThemTitleLabel!
    @IBOutlet weak var lblPlace: ThemTitleLabel!
    @IBOutlet weak var lblTime: ThemTitleLabel!
    @IBOutlet weak var lblDate: ThemTitleLabel!
    @IBOutlet weak var lblPrice: ThemTitleLabel!
    @IBOutlet weak var imgEvent: UIImageView!
    @IBOutlet weak var lblHostedBy: ThemTitleLabel!
    @IBOutlet weak var lblEventTitle: ThemTitleLabel!
    @IBOutlet weak var lblTicketTitle: ThemTitleLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActionPayment(_ sender: UIButton) {
        
    }
    
    @IBAction func btnActionApplePay(_ sender: UIButton) {
    }
    
}
