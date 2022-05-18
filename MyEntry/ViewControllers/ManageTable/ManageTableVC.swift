//
//  ManageTableVC.swift
//  MyEntry
//
//  Created by Vipul Dungranee on 23/02/22.
//

import UIKit

class ManageTableVC: UIViewController {

    //MARK:- ===== Outlets ======
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblTitle: ThemTitleLabel!
    @IBOutlet weak var ContentView: ThemeRoundPinkBGView!
    @IBOutlet weak var btnUpComing: UIButton!
    @IBOutlet weak var btnDrafts: UIButton!
    
    
    @IBOutlet weak var tblView: UITableView!
    
    var tableArray: [TableData] = [TableData]()
    
    //MARK:- ==== View Controller Life cycle =====
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(NotificationKeys.kuserProfileKey.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(displayProfile), name: Notification.Name(NotificationKeys.kuserProfileKey.rawValue), object: nil)
        dataSetup()
        
        
        tblView.register(UINib(nibName: "ManageTblCell", bundle: nil), forCellReuseIdentifier: "ManageTblCell")
        setDummyTableData()
    }
    
    func setDummyTableData(){
        for i in 0...5 {
            var data = TableData()
            data.tableName = "Table \(i)"
            data.totalSeats = i % 2 == 0 ? 6 : 8
            data.assignedSeats = 8 - (i + 1)
            data.vacantSeats = 8 - data.assignedSeats!
            tableArray.append(data)
        }
        
        tblView.reloadData()
    }
    
    func dataSetup(){
        if Singleton.sharedInstance.UserProfilData?.image != "" {
           // imgProfile.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgProfile.sd_setImage(with: URL(string: Singleton.sharedInstance.UserProfilData?.image ?? ""), placeholderImage: UIImage(named: "account"))
        }
        else {
            imgProfile.image = UIImage(named: "account")
        }
    }
    
    @objc func displayProfile(){
        if Singleton.sharedInstance.UserProfilData?.image != "" {
           // imgProfile.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgProfile.sd_setImage(with: URL(string: Singleton.sharedInstance.UserProfilData?.image ?? ""), placeholderImage: UIImage(named: "account"))
        }
        else {
            imgProfile.image = UIImage(named: "account")
        }
    }
    
    //MARK:- ======= Btn Action Menu ======
    @IBAction func btnActionMenu(_ sender: UIButton) {
        sideMenuController?.revealMenu()
    }
    
    //MARK:- ======= Btn Action Layout Tables ======
    @IBAction func btnActionLayoutTables(_ sender: UIButton) {
        let layoutTableVC : LayoutTablesVC = LayoutTablesVC.instantiate(appStoryboard: .Table)
        
        self.navigationController?.pushViewController(layoutTableVC, animated: true)

    }
    
    //MARK:- ======= Btn Action Add Table ======
    @IBAction func btnActionAddTable(_ sender: UIButton) {
        let createTableVC : CreateTableVC = CreateTableVC.instantiate(appStoryboard: .Table)
        
        self.navigationController?.pushViewController(createTableVC, animated: true)

    }
}

// MARK: UITableViewDataSource
extension ManageTableVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ManageTblCell") as? ManageTblCell {
            
            cell.congifureCellData(tableData: tableArray[indexPath.row])
            cell.onEditClick = { [weak self] in
                self?.navigateToEditTableScreen(for: indexPath.row)
            }
            
            print("table[\(indexPath.row)] \(tableArray[indexPath.row])")
            return cell
        }
        
        return UITableViewCell()
    }
    
    
    func navigateToEditTableScreen(for tableIndex: Int) {
        let editTableVC : EditTableVC = EditTableVC.instantiate(appStoryboard: .Table)
        
        self.navigationController?.pushViewController(editTableVC, animated: true)

    }
    
}

// MARK: UITableViewDataSource
extension ManageTableVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

