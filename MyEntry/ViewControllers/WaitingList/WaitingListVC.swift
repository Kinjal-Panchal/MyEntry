//
//  WaitingListVC.swift
//  MyEntry
//
//  Created by Kinjal panchal on 26/02/22.
//

import UIKit

class WaitingListVC: UIViewController {

    //MARK:- ======= Outlets ======
    @IBOutlet weak var tblWaiting: UITableView!
    @IBOutlet weak var lblDate: ThemTitleLabel!
    @IBOutlet weak var lblTitle: ThemTitleLabel!
    
    //MARK: - ===== Variables =====
    var arrParticipent = [ParticipentData]()
    var objEvent : EventdetailData?

    override func viewDidLoad() {
        super.viewDidLoad()
        DataSetup()
        webServiceCallParticipent()
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - DataSetup ====
    func DataSetup(){
        let strDate = UtilityClass.DateStringChange(Format:StrdateFormatter.StrYMD.rawValue, getFormat: StrdateFormatter.strDMY.rawValue, dateString: objEvent?.eventDate ?? "")
         if objEvent?.allDayEvent == "yes" {
            lblDate.text = strDate
         }
         else {
            lblDate.text = "\(strDate) at \(objEvent?.startTime ?? "")"
         }
         lblTitle.text = objEvent?.eventTitle
      }
}

//MARK: ====== TableView DataSource and Delegate =====
extension WaitingListVC : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrParticipent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "waitingTblCell", for: indexPath) as! waitingTblCell
        if arrParticipent[indexPath.row].email != "" {
            cell.lblEmail.text = arrParticipent[indexPath.row].email
        }
        else if arrParticipent[indexPath.row].phone != "" {
            cell.lblEmail.text = "\(arrParticipent[indexPath.row].phoneCode ?? "")" + " " +  "\(arrParticipent[indexPath.row].phone ?? "")"
        }
        cell.imgProfile.image = UIImage(named: "account")
        cell.lblDuration.isHidden = arrParticipent[indexPath.row].status == "Pending" ? true : false
        cell.lblWaitingStatus.isHidden = arrParticipent[indexPath.row].status == "Pending" ? true : false
        cell.lblPendingStatus.isHidden = arrParticipent[indexPath.row].status == "Pending" ? false : true
        //cell.imgProfile.sd_setImage(with: URL(string: arrParticipent[indexPath.row]. ?? ""), placeholderImage: UIImage(named: "account"))
        cell.lblName.text = arrParticipent[indexPath.row].username
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension WaitingListVC {
    
    func webServiceCallParticipent(){
        LoaderClass.showActivityIndicator()
        let reqModel = EventDetailReqModel()
        reqModel.event_id = "\(objEvent?.id ?? 0)"
        WebServiceSubClass.ParticipateList(reqModel: reqModel) { status, message, response, error in
            LoaderClass.hideActivityIndicator()
            if status {
                print(response)
                if response?.data?.count != 0 {
                    self.arrParticipent = response?.data ?? []
                }
                self.tblWaiting.reloadData()
            }
            else{
                AlertMessage.showMessageForError(response?.message ?? "")
            }
        }
    }
}

class waitingTblCell : UITableViewCell {
    
    //MARK:- ====== Outlets =======
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: ThemTitleLabel!
    @IBOutlet weak var lblEmail: ThemTitleLabel!
    @IBOutlet weak var lblPendingStatus: ThemTitleLabel!
    @IBOutlet weak var lblDuration: ThemTitleLabel!
    @IBOutlet weak var lblWaitingStatus: ThemTitleLabel!
    
    
    override func awakeFromNib() {
        
    }
    
}
