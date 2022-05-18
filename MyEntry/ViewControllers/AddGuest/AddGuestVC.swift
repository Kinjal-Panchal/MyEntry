//
//  AddGuestVC.swift
//  MyEntry
//
//  Created by Kinjal Panchal on 24/10/21.
//

import UIKit

class AddGuestTblCell : UITableViewCell {
    
    //MARK:- ===== Outlets =====
    @IBOutlet weak var lblEmail: ThemTitleLabel!
    @IBOutlet weak var imgPic: UIImageView!
    @IBOutlet weak var lblName: ThemTitleLabel!
    @IBOutlet weak var addGuest: UIButton!
    
    //MARK:- ===== Variables =======
    var addGuestClick : (()->())?
    
    //MARK:- ===== Btn Action Add Guest =====
    @IBAction func btnActionAddGuest(_ sender: UIButton) {
        if let clicked = addGuestClick {
            clicked()
        }
    }
}

class AddGuestVC: UIViewController {

   //MARK:- ====== Outlets ======
    @IBOutlet var btnCollection: [UIButton]!
    @IBOutlet weak var tblUsers: UITableView!
    @IBOutlet weak var CollectionUsers: UICollectionView!
    @IBOutlet weak var continueBtnView: UIView!
    
    //MARK:-===== Variables =====
    var arrAppUsers = [ContactListData]()
    var arrContacts = [ContactListData]()
    var createEventrequestModel = CreateEventReqModel()
    var selectedGuests = [ContactListData]()
    var isFromAddTableScreen = false
    var selectedGuest : ((ContactListData?) -> ())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for btn in btnCollection {
            btn.setTitleColor(colors.ThemeGray.value , for: .normal)
            btn.titleLabel?.font = CustomFont.Medium.returnFont(18.0)
        }
        getContactList()
        webServiceCallUserList()
        tblUsers.allowsMultipleSelection = isFromAddTableScreen
        continueBtnView.isHidden = isFromAddTableScreen
    }
    
    //MARK:- ==== Btn Setup ===
    func UISetup(isSelceted : Bool){
//        for btn in btnCollection {
//            btn.setTitleColor(btn.isSelected == isSelceted ? colors.ThemeGray.value : UIColor(hexString: "#828282"), for: .normal)
//            btn.titleLabel?.font = CustomFont.Medium.returnFont(18.0)
//        }
    }
    
    @IBAction func btnActionCollectionType(_ sender: UIButton) {
//        for i in btnCollection {
//            i.isSelected = false
//            i.setTitleColor(UIColor(hexString: "#828282") , for: .normal)
//            i.titleLabel?.font = CustomFont.Medium.returnFont(18.0)
//        }
//        sender.isSelected = true
//        sender.setTitleColor(colors.ThemeGray.value , for: .normal)
    }
    
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        poupScreen()
    }
    
    func poupScreen() {
        if isFromAddTableScreen{
          self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btnActionContinue(_ sender: UIButton) {
        if selectedGuests.count != 0 {
            webserviceCallCreateEvent()
        }
        else{
            AlertMessage.showMessageForError("Please add guest for your event")
        }
    }
    
    //MARK:- ==== Webservice Call Create Event======
    func webserviceCallCreateEvent(){
        LoaderClass.showActivityIndicator()
        let guestsUserId = self.selectedGuests.map({String($0.id ?? 0)})
        print(guestsUserId)
        let joined = guestsUserId.joined(separator: ",")
        print(joined)
        print(self.selectedGuests.count)
        createEventrequestModel.guest_user_id = joined
        createEventrequestModel.user_id = Singleton.sharedInstance.UserId
        WebServiceSubClass.createEvent(CreateEventReqModel:createEventrequestModel) { status, message, response, error in
            LoaderClass.hideActivityIndicator()
            if status {
                print(response)
                NotificationCenter.default.post(name: Notification.Name(NotificationKeys.kUpdateEventList.rawValue), object: nil)
                let vc : InvitesVC = InvitesVC.instantiate(appStoryboard: .main)
                vc.obj = response?.data
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else {
                AlertMessage.showMessageForError(message)
            }
        }
    }
}

extension AddGuestVC : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddGuestTblCell", for: indexPath) as! AddGuestTblCell
        cell.lblName.text = arrContacts[indexPath.row].username
        cell.lblEmail.text = arrContacts[indexPath.row].phone
        cell.imgPic.image = UIImage(named: "account")
        cell.addGuest.isSelected = self.arrContacts[indexPath.row].isselected
        cell.addGuestClick = {
            self.selectedGuests.removeAll()
            self.arrContacts[indexPath.row].isselected =  !self.arrContacts[indexPath.row].isselected
            cell.addGuest.isSelected = !cell.addGuest.isSelected
            for i in self.arrContacts {
                if i.isselected == true {
                    self.selectedGuests.append(i)
                }
            }
            self.selectedGuest?(self.arrContacts[indexPath.row])
            self.poupScreen()
        }
        return cell
    }
}

extension AddGuestVC : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrAppUsers.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CollectionUsers.dequeueReusableCell(withReuseIdentifier: "AppUserCollectionViewCell", for: indexPath) as! AppUserCollectionViewCell
        cell.lblName.text = arrAppUsers[indexPath.row].username
        cell.imgProfile.image = UIImage(named: "account")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 65, height: CollectionUsers.frame.height)
    }
    
}
extension AddGuestVC {
    
    func webServiceCallUserList(){
        LoaderClass.showActivityIndicator()
        let param = [String:AnyObject]()

        WebServiceSubClass.appUsersList(reqmodel: param) { status, message, response, error in
            LoaderClass.hideActivityIndicator()
            if status {
                print(response)
                if response?.data?.count != 0 {
                    self.arrAppUsers = (response?.data)!
                    self.CollectionUsers.reloadData()
                }
            }
            else{
                AlertMessage.showMessageForError(message)
            }
        }
    }
    
    //MARK :- ==== Get ContactList =====
    func getContactList(){
        LoaderClass.showActivityIndicator()
        let remodel = EventListReqModel()
        remodel.user_id = Singleton.sharedInstance.UserId
        WebServiceSubClass.getContactList(ContactListReqModel: remodel) { status, message, response, error in
            LoaderClass.hideActivityIndicator()
            if status {
                print(response)
                let objData = response
                if objData?.data?.count != 0 {
                    self.arrContacts = (objData?.data)!
                }
                self.tblUsers.reloadData()
            }
            else{
                AlertMessage.showMessageForError(message)

            }
        }
    }
}
