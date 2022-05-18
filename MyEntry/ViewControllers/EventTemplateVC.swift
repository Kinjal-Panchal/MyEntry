//
//  EventTemplateVC.swift
//  MyEntry
//
//  Created by Kinjal Panchal on 24/10/21.
//

import UIKit
import SDWebImage


class EventTemplateCollectionviewCell : UICollectionViewCell {
    
    //MARK:- ===== Outlets =====
    @IBOutlet weak var imgTemplate: UIImageView!
    @IBOutlet weak var viewBG: UIView!
    
}

class EventTemplateVC: UIViewController {

    //MARK:- ===== Outlets =====
    @IBOutlet weak var lblCount: ThemTitleLabel!
    @IBOutlet weak var lblSubTitle: ThemTitleLabel!
    @IBOutlet weak var viewBtnUploadTemplate: UIView!
    @IBOutlet weak var collectionTemplate: UICollectionView!
    @IBOutlet weak var btnUploadNewTemplate: UIButton!
    
    //MARK:- Variables =====

    var arrTemplate = [TemplateList]()
    private lazy var imagePicker: ImagePicker = {
            let imagePicker = ImagePicker()
            imagePicker.delegate = self
            return imagePicker
        }()
    var selectedIndex = NSNotFound
    var createEventrequestModel = CreateEventReqModel()
    var categoryId = String()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewBtnUploadTemplate.addDashedBorder()
        webServicecallTemplateList()
        lblSubTitle.contentMode = .center
        //viewBtnUploadTemplate.addLineDashedStroke(pattern: [2, 2], radius:10, color: UIColor(hexString: "#C4C4C4").cgColor)
        btnUploadNewTemplate.titleLabel?.textColor = colors.ThemeGray.value
        btnUploadNewTemplate.titleLabel?.font = CustomFont.Bold.returnFont(10.0)

    }
    
    //MARK:- ===== Btn Action add Template  =====
    @IBAction func btnActionOwnTemplate(_ sender: UIButton) {
        imagePicker.photoGalleryAsscessRequest()
        
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK:- ===== btn Action next =====
    @IBAction func btnActionContinue(_ sender: UIButton) {
        if selectedIndex != NSNotFound {
            let eventinfoVC : CreateEventInfoVC = CreateEventInfoVC.instantiate(appStoryboard: .main)
            eventinfoVC.createEventrequestModel = createEventrequestModel
            self.navigationController?.pushViewController(eventinfoVC, animated: true)
        }
        else {
            AlertMessage.showMessageForError("Please select event template")
        }
        
    }
    
    //MARK:- ===== Webservice Call Template list ====
    func webServicecallTemplateList(){
        LoaderClass.showActivityIndicator()
        let reqModel = TemplatListReqModel()
        reqModel.user_id = "\(Singleton.sharedInstance.UserProfilData?.id ?? 0)"
        reqModel.category_id = categoryId
        
        WebServiceSubClass.templatelist(templatlistReqmodel: reqModel) { status, message, response, error in
            LoaderClass.hideActivityIndicator()
            if status {
                print(response)
                if response?.data?.count != 0 {
                    guard let obj  = response?.data else {return}
                    self.arrTemplate = obj
                    self.lblCount.text = "\(self.arrTemplate.count)"
                }
                self.collectionTemplate.reloadData()
                
            }
            else{
                AlertMessage.showMessageForError(message)
            }
        }
    }
    
    //MARK:- ==== Add Template Webservice =====
      func webServiceCallAddTemplate(image:UIImage){
          LoaderClass.showActivityIndicator()
          let reqmodel = TemplateReqModel()
          reqmodel.user_id = Singleton.sharedInstance.UserId
          reqmodel.name = "Template"
          reqmodel.category_id = categoryId
          
          WebServiceSubClass.uploadTemplate(TemplateImg: image, TemplateReqModel: reqmodel) { status, message, response, error in
              LoaderClass.hideActivityIndicator()
              if status {
                  print(response)
                  AlertMessage.showMessageForSuccess(response?.message ?? "")
                  self.webServicecallTemplateList()
              }
              else {
                  AlertMessage.showMessageForError(message)
              }
          }
      }
    @objc func photoButtonTapped(_ sender: UIButton) { imagePicker.photoGalleryAsscessRequest() }
    
    @objc func cameraButtonTapped(_ sender: UIButton) { imagePicker.cameraAsscessRequest() }
}

// MARK: ImagePickerDelegate
extension EventTemplateVC : ImagePickerDelegate {

    func imagePicker(_ imagePicker: ImagePicker, didSelect image: UIImage) {
        webServiceCallAddTemplate(image: image)
        imagePicker.dismiss()
    }

    func cancelButtonDidClick(on imageView: ImagePicker) { imagePicker.dismiss() }
    func imagePicker(_ imagePicker: ImagePicker, grantedAccess: Bool,
                     to sourceType: UIImagePickerController.SourceType) {
        guard grantedAccess else { return }
        imagePicker.present(parent: self, sourceType: sourceType)
    }
    
}

extension EventTemplateVC : UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrTemplate.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventTemplateCollectionviewCell", for: indexPath) as! EventTemplateCollectionviewCell
        //cell.imgTemplate.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.imgTemplate.sd_setImage(with: URL(string: arrTemplate[indexPath.row].thumbImage500 ?? ""), placeholderImage: nil)
        
        cell.viewBG.layer.borderColor = arrTemplate[indexPath.row].selected == true ? colors.ThemeYellow.value.cgColor : UIColor.clear.cgColor
        cell.viewBG.layer.borderWidth = arrTemplate[indexPath.row].selected == true ? 2 : 0
        
        
//        UtilityClass.imageGet(url: arrTemplate[indexPath.row].thumbImage500!, img: cell.imgTemplate)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionTemplate.frame.width/1.2, height: collectionTemplate.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        arrTemplate.map({$0.selected = false})
        selectedIndex = indexPath.row
        arrTemplate[selectedIndex].selected = true
        createEventrequestModel.template_id = "\(arrTemplate[selectedIndex].id ?? 0)"
        collectionTemplate.reloadData()
        
//        let templateVc = EventTemplateVC.instantiate(appStoryboard: .main)
//        self.navigationController?.pushViewController(templateVc, animated: true)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let centerPoint = CGPoint(x: collectionTemplate.bounds.midX, y: collectionTemplate.bounds.midY)

         if let indexPath = collectionTemplate.indexPathForItem(at: centerPoint) {
             print(indexPath.row)
             lblCount.text = "\(indexPath.row + 1)"
         }
//        let offSet = scrollView.contentOffset.x
//        let width = scrollView.frame.width
//        let horizontalCenter = width / 2
//
//        let pageNo = Int(offSet + horizontalCenter) / Int(width)
//        lblCount.text = "\(pageNo)"
    }

   
    
}
