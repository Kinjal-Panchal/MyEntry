//
//  DetailVC.swift
//  MyEntry
//
//  Created by Kinjal panchal on 29/12/21.
//

import UIKit

class DetailVC: UIViewController {

    //MARK: - ===== Outlets ========
    @IBOutlet weak var conHeightOfTbl: NSLayoutConstraint!
    @IBOutlet weak var tblEvents: UITableView!
    @IBOutlet weak var lblTotalGuest: ThemTitleLabel!
    @IBOutlet weak var imgEventIcon: UIImageView!
    @IBOutlet weak var lblHosted: ThemTitleLabel!
    @IBOutlet weak var lblEventTitle: UILabel!
    @IBOutlet weak var lbltime: ThemTitleLabel!
    @IBOutlet weak var lblLocation: ThemTitleLabel!
    @IBOutlet weak var imgBG: UIImageView!
    @IBOutlet weak var lblDate: ThemTitleLabel!
    @IBOutlet weak var lblWaitListed: ThemTitleLabel!
    @IBOutlet weak var lblVacant: ThemTitleLabel!
    @IBOutlet weak var lblAssigned: ThemTitleLabel!
    @IBOutlet weak var lblTotalSeats: ThemTitleLabel!
    @IBOutlet weak var lblTotalTable: ThemTitleLabel!
    
    
    //MARK: - Variables ====
    var eventID : String = ""
    var arrTickets = [TicketData]()
    var objEvent : RootEventDetail?
    
    
    //MARK: - ===== View Controller Life Cycle ========
    override func viewDidLoad() {
        super.viewDidLoad()
        webServiceCallEventDetail()
    }
    
    //MARK: - DataSetup ====
    func DataSetup(obj:EventdetailData){
        lblDate.text = UtilityClass.getDateString(dateString: obj.eventDate )
        lbltime.text = obj.allDayEvent == "yes" ? "full day" : "\(obj.startTime)-\(obj.endTime)"
        lblLocation.text = obj.address
        lblEventTitle.text = obj.eventTitle
        lblHosted.text = "Hosted by \(obj.hostName)"
        lblTotalGuest.text = "\(obj.totalGuest)\nGuests"
       // cell.imgTemplate.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imgBG.sd_setImage(with: URL(string: obj.templateImage), placeholderImage: UIImage(named: "account"))
        imgEventIcon.sd_setImage(with: URL(string: obj.eventIcon), placeholderImage: UIImage(named: "account"))
        lblTotalTable.text = "\(objEvent?.tableData?.totalTable ?? 0) Tables"
        lblTotalSeats.text = "\(objEvent?.tableData?.totalSeats ?? 0) Seats"
        //lblAssigned.text = objEvent?.tableData?.
        lblVacant.text = "\(objEvent?.tableData?.totalVacant ?? 0) Vacant"
        lblWaitListed.text = "\(objEvent?.tableData?.totalWaitlist ?? 0) Waitlisted"
    }

    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnActionCreateTicket(_ sender: UIButton) {
        let createTicketVC : CreateTicketVC = CreateTicketVC.instantiate(appStoryboard: .main)
        createTicketVC.eventId = eventID
        self.navigationController?.pushViewController(createTicketVC, animated: true)
    }
    
    @IBAction func btnActionMessageDelievr(_ sender: UIButton) {
        let vc : MessageDeliveryVC = MessageDeliveryVC.instantiate(appStoryboard: .main)
        vc.objEvent = objEvent?.data
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnActionCreateTable(_ sender: Any) {
        let createTableVC : CreateTableVC = CreateTableVC.instantiate(appStoryboard: .main)
        self.navigationController?.pushViewController(createTableVC, animated: true)
    }
}

//MARK: ==== Webservice Call Event Details ====
extension DetailVC {
    func webServiceCallEventDetail(){
        LoaderClass.showActivityIndicator()
        let reqModel = EventDetailReqModel()
        reqModel.event_id = eventID
        WebServiceSubClass.eventDetail(reqModel: reqModel) { [self] status, message, resonse, error in
            LoaderClass.hideActivityIndicator()
            if status {
                print(resonse)
                let obj = resonse?.data
                self.objEvent = resonse
                if obj?.ticketData.count != 0 {
                    self.arrTickets = obj!.ticketData
                    conHeightOfTbl.constant = tblEvents.contentSize.height
                }
                else{
                    self.tblEvents.contentSize.height = 0
                }
                self.tblEvents.reloadData()
                self.DataSetup(obj: obj!)
            }
            else {
                AlertMessage.showMessageForError(resonse?.message ?? "")
            }
        }
    }
}

extension DetailVC : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTickets.count != 0 ? arrTickets.count : 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblEvents.dequeueReusableCell(withIdentifier: "TicketTblCell", for: indexPath) as! TicketTblCell
        cell.lblTicketTitle.text = arrTickets[indexPath.row].ticketTitle
        cell.lblDescription.text = arrTickets[indexPath.row].pricePerTicket
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        conHeightOfTbl.constant = tblEvents.contentSize.height
    }
}

class TicketTblCell : UITableViewCell {
    
    @IBOutlet weak var lblTicketTitle: ThemTitleLabel!
    @IBOutlet weak var lblDescription: ThemTitleLabel!
}
