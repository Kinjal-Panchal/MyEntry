//
//  MyContactVC.swift
//  MyEntry
//
//  Created by panchal kinjal  on 04/10/21.
//

import UIKit
import Contacts
import ContactsUI

struct AddressModel {
    let nameAndPhone: [AddressContact]
}

struct AddressContact {
    let contact: CNContact
    
}
class Contact : NSObject{

    var buttonType : String!
    var id : String!
    var name : String!
    var phone : String!
    var profilePicture : String!
    var thumbnil : Data?
    var email:String!
    
    
    init(ButtonType : String , Id : String , Name : String , ProfilePicture : String , Thumbnil : Data? , Phone : String,email:String) {
        self.buttonType = ButtonType
        self.id = Id
        self.name = Name
        self.thumbnil = Thumbnil
        self.profilePicture = ProfilePicture
        self.phone = Phone
        self.email = email
    }
}


class MyContactVC: UIViewController , CNContactViewControllerDelegate , CNContactPickerDelegate{

    //MARK:- ===== Outlets ======
    @IBOutlet weak var tblContacts: UITableView!
    
    let newContact = CNMutableContact()
    let store = CNContactStore()
    var addressArray = [AddressModel]()
    var objData = [Contact]()
    var arrUserList = [ContactListData]()

    
    //MARK:- ===== ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchContacts(showHud: true)
        //tblContacts.register(UINib(nibName: "ContactTblCell", bundle: nil), forCellReuseIdentifier: "ContactTblCell")

    }
    
    //MARK:- === Btn Action Add ==== 
    @IBAction func btnActionAddContacts(_ sender: UIButton) {
             let openContact = CNContact()
            let vc = CNContactViewController(forNewContact: openContact)
             vc.delegate = self // this delegate CNContactViewControllerDelegate
           // self.navigationController?.pushViewController(vc, animated: true)
           self.present(UINavigationController(rootViewController: vc), animated:true)
    }
    
    
    func contactViewController(_ viewController: CNContactViewController, didCompleteWith contact: CNContact?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK:- ===== Btn Action Menu ===
    @IBAction func btnActionMenu(_ sender: UIButton) {
       self.sideMenuController?.revealMenu()
    }
    
    
    func requestForContactAccess(completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
        let authorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        switch authorizationStatus {
        case .authorized:
            completionHandler(true)
        case .denied, .notDetermined:
            self.store.requestAccess(for: CNEntityType.contacts, completionHandler: { (access, accessError) -> Void in
                if access {
                    LoaderClass.showActivityIndicator()
                    completionHandler(access)
                } else {
                    if authorizationStatus == CNAuthorizationStatus.denied {
                        DispatchQueue.main.async(execute: { () -> Void in
                            _ = "\(accessError!.localizedDescription)\n\nPlease allow the app to access your contacts through the Settings."
                            UtilityClass.CheckContact(Title:Constant.AppName, currentVC: self)
                        })
                    }
                }
            })
        default:
            completionHandler(false)
        }
    }
    private func fetchContacts(showHud:Bool) {
        print("Attempting to fetch contacts today")
        
         
       if showHud {
           LoaderClass.showActivityIndicator()
        }
               
        let store = CNContactStore()
        
        store.requestAccess(for: .contacts) { (granted, err) in
            if let err = err {
                print("Failed to request access:", err.localizedDescription)
                DispatchQueue.main.async {
                    
                }
                //                return
            }
            if granted {
                LoaderClass.hideActivityIndicator()
                 
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactImageDataAvailableKey, CNContactImageDataKey,CNContactIdentifierKey]
                // let keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactPhoneNumbersKey , CNContactImageDataAvailableKey] as [Any]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                request.sortOrder = CNContactSortOrder.userDefault
                
                do {
                    var addressContact = [AddressContact]()
                    
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stop) in
                        print(contact)
                        addressContact.append(AddressContact(contact: contact))
                    })
                    let nameAndPhone = AddressModel(nameAndPhone: addressContact)
                    self.addressArray = [nameAndPhone]
                    
                    self.objData.removeAll()
                    for i in self.addressArray {
                        for obj  in i.nameAndPhone {
                            if obj.contact.givenName != "" {
                                let userName = obj.contact.givenName + " " + obj.contact.familyName
                                let phoneCount = obj.contact.phoneNumbers.count
                                if phoneCount == 1 {

                                  //  self.setNumberFromContact(contactNumber: obj.contact.phoneNumbers[0].value.stringValue)


                                    if obj.contact.imageDataAvailable {
                                        let image = obj.contact.imageData ?? Data()

                                        self.objData.append(Contact(ButtonType: "", Id: "", Name: userName, ProfilePicture: "", Thumbnil: image, Phone: obj.contact.phoneNumbers[0].value.stringValue, email: ""))

                                    }
                                    else {
//
                                        self.objData.append(Contact(ButtonType: "", Id: "", Name: userName, ProfilePicture: "", Thumbnil: nil, Phone: obj.contact.phoneNumbers[0].value.stringValue, email:""))
                                    }
                                }
                                else {
                                    for i in obj.contact.phoneNumbers{
                                        //self.setNumberFromContact(contactNumber:i.value.stringValue)
                                        if obj.contact.imageDataAvailable {
                                            let image = obj.contact.imageData
                                            self.objData.append(Contact(ButtonType: "", Id: "", Name: userName, ProfilePicture: "", Thumbnil: image ?? Data(), Phone: obj.contact.phoneNumbers[0].value.stringValue, email: ""))

                                        }
                                        else {
                                            self.objData.append(Contact(ButtonType: "", Id: "", Name: userName, ProfilePicture: "", Thumbnil: nil, Phone: obj.contact.phoneNumbers[0].value.stringValue, email: ""))

                                        }
                                    }
                                }
                            }
                        }
                    }
                print(self.objData.count)
                self.webserviceCallSyncContactList()
//                    if !Connectivity.isConnectedToInternet() {
//                        AlertMessage.showMessageForError(Constant.NoInternetMessage)
//                        DispatchQueue.main.async {
//                            LoaderClass.hideActivityIndicator()
//                        }
//                    }
//                    else{
//
//                        //self.webserviceCallForUserList(showHud: showHud)
//                    }
                    
                } catch let err {
                    DispatchQueue.main.async {
                      LoaderClass.hideActivityIndicator()
                    }
                    print("Failed to enumerate contacts:", err.localizedDescription)
                }
            } else {
                
                DispatchQueue.main.async {
                        LoaderClass.hideActivityIndicator()

                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    UtilityClass.CheckContact(Title: Constant.AppName, currentVC: self)
                }
            }
        }
    }
    
    //MARK:- ==== Webservice Call Syns contacts ====
    func webserviceCallSyncContactList(){
        LoaderClass.showActivityIndicator()
        let reqModel = ConatactListReqModel()
        
        var Contactdict = [[String : Any]]()
        Contactdict.removeAll()
        objData = objData.filter({$0.phone != Singleton.sharedInstance.UserProfilData?.phone})
        for i in objData{
            Contactdict.append(["name" : i.name ?? "" , "phone" : i.phone as Any , "email" : i.email as Any])
        }
        //.removingWhitespaces()
        let jsonData = try! JSONSerialization.data(withJSONObject: Contactdict, options: [])
        let json = String(data: jsonData, encoding: .utf8)
        print(json!)
        reqModel.user_id = Singleton.sharedInstance.UserId
        reqModel.contacts = json
        
        WebServiceSubClass.syncContactData(ContactReqModel: reqModel) { status, message, response, error in
            LoaderClass.hideActivityIndicator()
            if status {
                print(response)
                self.getContactList()
            }
            else {
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
                    self.arrUserList = (objData?.data)!
                }
                self.tblContacts.reloadData()
            }
            else{
                AlertMessage.showMessageForError(message)

            }
        }
    }
}

extension MyContactVC : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrUserList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTblCell", for: indexPath) as! ContactTblCell
        cell.lblName.text = arrUserList[indexPath.row].username
        cell.lblNumber.text = arrUserList[indexPath.row].phone
        cell.imgProfile.image = UIImage(named: "account")
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
