//
//  LayoutTablesVC.swift
//  MyEntry
//
//  Created by Vipul Dungranee on 25/02/22.
//

import UIKit

class LayoutTablesVC: UIViewController {
    
    //MARK:- ===== Outlets ======
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblTitle: ThemTitleLabel!
    @IBOutlet weak var ContentView: ThemeRoundPinkBGView!
    @IBOutlet weak var btnUpComing: UIButton!
    @IBOutlet weak var btnDrafts: UIButton!
    
    var screenWidth = UIScreen.main.bounds.width
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var tableArray: [TableData] = [TableData]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(NotificationKeys.kuserProfileKey.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(displayProfile), name: Notification.Name(NotificationKeys.kuserProfileKey.rawValue), object: nil)
        dataSetup()
        
        
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
        
        collectionView.reloadData()
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
        let createTableVC : CreateTableVC = CreateTableVC.instantiate(appStoryboard: .Table)
        
        self.navigationController?.pushViewController(createTableVC, animated: true)

    }
    
    //MARK:- ======= Btn Action Add Table ======
    @IBAction func btnActionAddTable(_ sender: UIButton) {
        let createTableVC : CreateTableVC = CreateTableVC.instantiate(appStoryboard: .Table)
        
        self.navigationController?.pushViewController(createTableVC, animated: true)

    }
    
    
}


extension LayoutTablesVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LayoutTablesCollCell", for: indexPath) as? LayoutTablesCollCell {
            
            cell.congifureCellData(tableData: tableArray[indexPath.row])
            print("table[\(indexPath.row)] \(tableArray[indexPath.row])")
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension LayoutTablesVC: UICollectionViewDelegateFlowLayout {
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
         return CGSize(width: 85, height: 85)
    }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         
         return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

}

