//
//  EventTypesVC.swift
//  MyEntry
//
//  Created by Kinjal Panchal on 19/10/21.
//

import UIKit
import SDWebImage

class EventTypesVC: UIViewController {

    
    //MARK:- ==== Output ====
    @IBOutlet weak var collectionEvent: UICollectionView!
    
    var objEvent : EventData!

    
    //MARK:- ===== Variables =====
    //var arrEvent = ["Wedding","Birthday","Baby Shower","Seasonal","Gala or Fundraiser","Show or Performance","Corporate","Other"]
    var arrCategories = [CategoriesData]()
    var createEventrequestModel = CreateEventReqModel()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webServiceCallEventCategories()
        
    }
    
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}

extension EventTypesVC : UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventTypeCollCell", for: indexPath) as! EventTypeCollCell
        cell.lblEventType.text = arrCategories[indexPath.row].name
       // cell.imgEventType.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.imgEventType.sd_setImage(with: URL(string: arrCategories[indexPath.row].thumbImage250 ?? ""), placeholderImage: nil)
        
        //UtilityClass.imageGet(url: arrCategories[indexPath.row].thumbImage250!, img: cell.imgEventType)
        //cell.imgEventType.image = UIImage(named:arrEvent[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionEvent.frame.width/2 , height: collectionEvent.frame.width/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        createEventrequestModel.category_id = "\(arrCategories[indexPath.row].id ?? 0)"
        let templateVc : EventTemplateVC = EventTemplateVC.instantiate(appStoryboard: .main)
        templateVc.categoryId = "\(arrCategories[indexPath.row].id ?? 0)"
        templateVc.createEventrequestModel = createEventrequestModel
        self.navigationController?.pushViewController(templateVc, animated: true)
    }
    
}

extension EventTypesVC {
    
    func webServiceCallEventCategories(){
        LoaderClass.showActivityIndicator()
        let param = [String:AnyObject]()
        WebServiceSubClass.categoriesList(reqmodel: param) { [self] status, message, response, error in
            LoaderClass.hideActivityIndicator()
            if status {
                print(response)
                arrCategories = (response?.data)!
                collectionEvent.reloadData()
            }
            else{
                AlertMessage.showMessageForError(message)
            }
        }
    }
    
  
}
