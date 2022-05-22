//
//  UpComingEventVC.swift
//  MyEntry
//
//  Created by Kinjal panchal on 28/11/21.
//

import UIKit
import SDWebImage

class EventCell :  UICollectionViewCell {
    
    //MARK: - ====== Outlets ======
    @IBOutlet weak var lblDate: ThemTitleLabel!
    @IBOutlet weak var lblHostedBy: ThemTitleLabel!
    @IBOutlet weak var lblEventTitle: ThemTitleLabel!
    @IBOutlet weak var lblTime: ThemTitleLabel!
    @IBOutlet weak var lblLocation: ThemTitleLabel!
    @IBOutlet weak var lblGuests: ThemTitleLabel!
    @IBOutlet weak var iconEvent: UIImageView!
    @IBOutlet weak var imgTemplate: UIImageView!
    
    var btnClicked : (() -> ())?
    
    //MARK: - ==== Action Detail =====
    @IBAction func btnActionDetail(_ sender: UIButton) {
        if let clicked = btnClicked{
            clicked()
        }
    }
}


class UpComingEventVC: UIViewController {

    //MARK: - ====== Outlets ====
    @IBOutlet weak var collectionUserEvent: UICollectionView!
    @IBOutlet weak var tblEvents: UITableView!
    @IBOutlet weak var NodataView: ThemeRoundPinkBGView!
    @IBOutlet weak var conHeightOfCollection: NSLayoutConstraint!
    
    //MARK:- ===== Variables ====
    var arrEventList = [EventData]()
    var arrUpComingEvent = [RootUpcomingEventData]()
    var arrDraftEventList = [EventData]()
    
    //MARK: - ===== View Controller Life Cycle ===
    override func viewDidLoad() {
        super.viewDidLoad()
        tblEvents.register(UINib(nibName: "HeaderEventCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderEventCell")
          webserviceCallUserEventList()
          webserviceCallUpComingEventList()
        webserviceCallDraftEventList()
    }
    
    @IBAction func btnActionAddEvent(_ sender: UIButton) {
        let createEventVC = CreateEventVC.instantiate(appStoryboard: .main)
        self.navigationController?.pushViewController(createEventVC, animated: true)
    }
    
}

//MARK: - ===== CollectionView DataSource and Delegate =====
extension UpComingEventVC : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrEventList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCell", for: indexPath) as! EventCell
        let obj = arrEventList[indexPath.row]

        cell.lblDate.text = UtilityClass.getDateString(dateString: obj.eventDate ?? "2021-12-09")
    
        cell.lblTime.text = obj.allDayEvent == "yes" ? "full day" : obj.eventTime //"\(obj.startTime ?? "")-\(obj.endTime ?? "")"
        cell.lblLocation.text = obj.address
        cell.lblEventTitle.text = obj.eventTitle
        cell.lblHostedBy.text = "Hosted by \(obj.hostName ?? "")"
        cell.lblGuests.text = "\(obj.totalGuest ?? 0)\nGuests"
       // cell.imgTemplate.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.imgTemplate.sd_setImage(with: URL(string: obj.templateImage ?? ""), placeholderImage: UIImage(named: "account"))
        cell.iconEvent.sd_setImage(with: URL(string: obj.eventIcon ?? ""), placeholderImage: UIImage(named: "account"))
        cell.btnClicked = {
            let detailVc : DetailVC = DetailVC.instantiate(appStoryboard: .main)
            detailVc.eventID = "\(self.arrEventList[indexPath.row].id ?? 0)"
            self.navigationController?.pushViewController(detailVc, animated: true)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionUserEvent.frame.size.width, height: collectionUserEvent.frame.size.height)
      }
    
}

//MARK: - =======  Tableview DataSource and Delegate ======
extension UpComingEventVC : UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrUpComingEvent.count != 0 ? arrUpComingEvent.count : 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrUpComingEvent[section].data?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyEventTblCell", for: indexPath) as! MyEventTblCell
        let obj = arrUpComingEvent[indexPath.section].data?[indexPath.row]
        //cell..text = UtilityClass.getDateString(dateString: obj.eventDate ?? "2021-12-09")
    
        cell.lblEventTime.text = obj?.allDayEvent == "yes" ? "full day" : obj?.eventTime //"\(obj?.startTime ?? "")-\(obj?.endTime ?? "")"
       // cell.lblLocation.text = obj.address
        cell.lblEventName.text = obj?.eventTitle
        cell.lblHosted.text = "Hosted by \(obj?.hostName ?? "")"
       // cell.lblGuests.text = "\(obj.totalGuest ?? 0)\nGuests"
        //cell.imgTemplate.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.imgTemplate.sd_setImage(with: URL(string: obj?.templateImage ?? ""), placeholderImage: UIImage(named: "account"))
        //cell.iconEvent.sd_setImage(with: URL(string: obj.eventIcon ?? ""), placeholderImage: UIImage(named: "account"))
        cell.btnClicked = {
            let detailVc : GuestEventDetailVC = GuestEventDetailVC.instantiate(appStoryboard: .main)
             detailVc.obj = obj
            detailVc.isFromDetail = true
            self.navigationController?.pushViewController(detailVc, animated: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderEventCell") as! HeaderEventCell
        let strDate = UtilityClass.getDateString(dateString: arrUpComingEvent[section].date ?? "")
        let arrStr = strDate.components(separatedBy: " ")
        headerView.lblDate.text = arrStr[1]
        headerView.lblMonth.text = arrStr[0]
        //headerView.backgroundColor = .blue
            return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}

//MARK:- ==== WebserviceCall Eventlist
extension UpComingEventVC {
    
    //MARK: - ===== WebService Call Event List ====
    func webserviceCallUserEventList(){
        LoaderClass.showActivityIndicator()
        let reqModel = EventListReqModel()
        reqModel.user_id = "\(Singleton.sharedInstance.UserProfilData?.id ?? 0)"
        reqModel.type = "user"
        
        WebServiceSubClass.EventListType(eventReqModel: reqModel) { status, message, response, error in
            LoaderClass.hideActivityIndicator()
            if status {
                print(response)
                if response?.data?.count != 0 {
                    guard let events = response?.data else { return }
                    self.arrEventList = events
                    self.collectionUserEvent.isHidden = false
                    DispatchQueue.main.async {
                        self.collectionUserEvent.reloadData()
                    }
                }
                else {
                    self.arrEventList.removeAll()
                    self.collectionUserEvent.isHidden = true
                    self.conHeightOfCollection.constant = 0
                }
            }
            else {
                
            }
          }
        }
    
    //MARK:- ===== WebService Call Event List ====
    func webserviceCallDraftEventList(){
        LoaderClass.showActivityIndicator()
        let reqModel = EventListReqModel()
        reqModel.user_id = "\(Singleton.sharedInstance.UserProfilData?.id ?? 0)"
        reqModel.type = "draft"
        
        WebServiceSubClass.EventListType(eventReqModel: reqModel) { status, message, response, error in
            LoaderClass.hideActivityIndicator()
            if status {
                print(response)
//                    self.arrDraftEventList = response?.data
                if response?.data?.count != 0 {
                    guard let events = response?.data else { return }
                    self.arrDraftEventList = events
                }
            }
            else {
                
            }
          }
        }
    
    //MARK: - ===== WebService Call Event List ====
    func webserviceCallUpComingEventList(){
        LoaderClass.showActivityIndicator()
        let reqModel = EventListReqModel()
        reqModel.user_id = "\(Singleton.sharedInstance.UserProfilData?.id ?? 0)"
        reqModel.type = "upcoming"
        
        WebServiceSubClass.UpcomingEventList(eventReqModel: reqModel) { status, message, response, error in
            LoaderClass.hideActivityIndicator()
            if status {
                print(response)
                if response?.data?.count != 0 {
                    guard let events = response?.data else { return }
                    self.arrUpComingEvent = events
                    self.tblEvents.isHidden = false
                    DispatchQueue.main.async {
                        self.tblEvents.reloadData()
                    }
                }
                else {
                    self.arrUpComingEvent.removeAll()
                    self.tblEvents.isHidden = true
                    //self.noEvents.isHidden = false
                }
            }
            else {
                
            }
        }
        
        
        
//        WebServiceSubClass.EventListType(eventReqModel: reqModel) { status, message, response, error in
//            LoaderClass.hideActivityIndicator()
//            if status {
//                print(response)
//                if response?.data?.count != 0 {
//                    guard let events = response?.data else { return }
//                    self.arrEventList = events
//                    //self.noEvents.isHidden = true
//                    DispatchQueue.main.async {
//                        self.collectionUserEvent.reloadData()
//                    }
//                }
//                else {
//                    self.arrEventList.removeAll()
//                    self.collectionUserEvent.isHidden = true
//                    //self.noEvents.isHidden = false
//                }
//            }
//            else {
//
//            }
//          }
        }
}
