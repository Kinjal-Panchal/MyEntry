//
//  SubScriptionVC.swift
//  MyEntry
//
//  Created by panchal kinjal  on 05/10/21.
//

import UIKit

class SubscriptionCell : UITableViewCell {
    
    @IBOutlet weak var lblFeature: ThemTitleLabel!
    @IBOutlet weak var lblOfferTitle3: ThemTitleLabel!
    @IBOutlet weak var lblOfferTitle2: ThemTitleLabel!
    @IBOutlet weak var lblOfferTitle1: ThemTitleLabel!
    @IBOutlet weak var lblPrice: ThemTitleLabel!
    @IBOutlet weak var lblMonth: ThemTitleLabel!
}

class SubScriptionVC: UIViewController {

    //MARK:- ===== Outlets ====
    @IBOutlet weak var tblSubscription: UITableView!
    
    //MARK:- === Variables ==
    var arrFeatures = [String]()
    var objResponse : RootSubscriptionPlanList?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        WebServiceSubScriptionList()
        // Do any additional setup after loading the view.
    }
    
    //MARK:-===== Btn Action Menu ====
    @IBAction func btnActionMenu(_ sender: UIButton) {
        sideMenuController?.revealMenu()
    }
    
    //MARK:-===== Btn Action Upgrade ====
    @IBAction func btnActionUpgrade(_ sender: UIButton) {
        let planVc : SubScriptionPlanVC = SubScriptionPlanVC.instantiate(appStoryboard: .main)
        planVc.arrPlans = objResponse?.data ?? []
        self.navigationController?.pushViewController(planVc, animated: true)
    }
    
    //MARK:- ==== SubScription PlanList ====
    func WebServiceSubScriptionList(){
        LoaderClass.showActivityIndicator()
        let param = [String:AnyObject]()
        WebServiceSubClass.subScriptionPlanList(reqmodel: param) { Status, message, response, error in
            LoaderClass.hideActivityIndicator()
            if Status {
                print(response)
                self.objResponse = response
                if response?.features?.count != 0 {
                    
                    self.arrFeatures = response?.features ?? []
                    self.tblSubscription.reloadData()
                }
            }
            else {
                AlertMessage.showMessageForError(message)
            }
        }
    }
}
extension SubScriptionVC : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFeatures.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblSubscription.dequeueReusableCell(withIdentifier: "SubscriptionCell", for: indexPath) as! SubscriptionCell
        cell.lblFeature.text = arrFeatures[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
