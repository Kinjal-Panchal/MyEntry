//
//  InvitesVC.swift
//  MyEntry
//
//  Created by Kinjal panchal on 05/11/21.
//

import UIKit

class InvitesVC: UIViewController {

    //MARK:- ====== Outlets =====
    @IBOutlet weak var viewStacks: UIStackView!
    @IBOutlet weak var lblHosted: ThemTitleLabel!
    @IBOutlet weak var lblGuests: ThemTitleLabel!
    @IBOutlet weak var lblEventTitle: ThemTitleLabel!
    @IBOutlet weak var lblTime: ThemTitleLabel!
    @IBOutlet weak var lblVenue: ThemTitleLabel!
    @IBOutlet weak var lblDate: ThemTitleLabel!
    @IBOutlet weak var imgTemplate: UIImageView!
    @IBOutlet weak var imgIcon: UIImageView!
    
    
    var obj : EventData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DataSetup()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewStacks.layer.cornerRadius = 10
        viewStacks.clipsToBounds = true
    }
    
    //MARK: - DataSetup ====
    func DataSetup(){
        lblDate.text = UtilityClass.getDateString(dateString: obj?.eventDate ?? "2021-12-09")
        lblTime.text = obj?.allDayEvent == "yes" ? "full day" : "\(obj?.startTime ?? "")-\(obj?.endTime ?? "")"
        lblVenue.text = obj?.address
        lblEventTitle.text = obj?.eventTitle
        lblHosted.text = "Hosted by \(obj?.hostName ?? "")"
        lblGuests.text = "\(obj?.totalGuest ?? 0)\nGuests"
       // cell.imgTemplate.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imgTemplate.sd_setImage(with: URL(string: obj?.templateImage ?? ""), placeholderImage: UIImage(named: "account"))
        imgIcon.sd_setImage(with: URL(string: obj?.eventIcon ?? ""), placeholderImage: UIImage(named: "account"))
    }
    
    @IBAction func btnActionReadyToSend(_ sender: UIButton) {
        
    }
    
    @IBAction func btnActionDetail(_ sender: UIButton) {
        
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnActiondone(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func btnActionshare(_ sender: UIButton) {

        if Singleton.sharedInstance.UserProfilData?.isSubScription == 1 {
                let text = "This is the text....."
                let textShare = [ text ]
                let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view
                self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func btnActionCopy(_ sender: UIButton) {
        
    }
    
    @IBAction func btnActionSendEmail(_ sender: UIButton) {
    }
}
