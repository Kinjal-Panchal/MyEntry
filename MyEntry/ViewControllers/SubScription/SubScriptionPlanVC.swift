//
//  SubScriptionPlanVC.swift
//  MyEntry
//
//  Created by Kinjal Panchal on 17/10/21.
//

import UIKit
import UPCarouselFlowLayout
import Stripe
import PassKit

class SubScriptionCollectionViewCell: UICollectionViewCell {
    
    //MARK:- ======= Outlets ==========
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAmmount: ThemTitleLabel!
    @IBOutlet weak var lblPlantitle3: ThemTitleLabel!
    @IBOutlet weak var lblPlanTitle2: ThemTitleLabel!
    @IBOutlet weak var lblPlanTitle1: ThemTitleLabel!
}


class SubScriptionPlanVC: UIViewController {
    
    //MARK:- ===== Outlets =====
    @IBOutlet weak var CollectionSubscriptionPlan: UICollectionView!
    
    //MARK:- ==== Variables ====
    var arrPlans = [PlanData]()
    var selectedIndex = NSNotFound
    var selctedplan : PlanData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            setupLayout()
        CollectionSubscriptionPlan.reloadData()
            //WebServiceSubScriptionList()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func setupLayout() {
           let layout = self.CollectionSubscriptionPlan.collectionViewLayout as! UPCarouselFlowLayout
           layout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset:50)
    }
    
    //MARK:- ===== Btn Action Menu ====
    @IBAction func btnActionMenu(_ sender: UIButton) {
        sideMenuController?.revealMenu()
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActionStripe(_ sender: UIButton) {
        let config = STPPaymentConfiguration()
        config.requiredBillingAddressFields = .full
        let viewController = STPAddCardViewController(configuration: config, theme: STPTheme.defaultTheme)
        viewController.delegate = self
        let navigationController = UINavigationController(rootViewController: viewController)
        present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func btnActionApplePay(_ sender: UIButton) {
        let request = PKPaymentRequest()
                request.merchantIdentifier = "merchant.net.mobindustry.likeMe"
                request.supportedNetworks = [PKPaymentNetwork.visa, PKPaymentNetwork.masterCard, PKPaymentNetwork.amex]
                request.merchantCapabilities = PKMerchantCapability.capability3DS
                request.countryCode = "US"
                request.currencyCode = "USD"
                
                request.paymentSummaryItems = [
                    PKPaymentSummaryItem(label: "Some Product", amount: 9.99)
                ]
                
                let applePayController = PKPaymentAuthorizationViewController(paymentRequest: request)
                self.present(applePayController!, animated: true, completion: nil)
               applePayController?.delegate = self
    }
}
extension SubScriptionPlanVC : STPAddCardViewControllerDelegate {
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreatePaymentMethod paymentMethod: STPPaymentMethod, completion: @escaping STPErrorBlock) {
        print(STPToken.self)
        self.dismiss(animated: true)
    }
    
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension SubScriptionPlanVC : UICollectionViewDataSource , UICollectionViewDelegate , UIScrollViewDelegate , UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrPlans.count != 0 ? arrPlans.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if  arrPlans.count != 0 {
            
            let cell =
                collectionView.dequeueReusableCell(withReuseIdentifier: "SubScriptionCollectionViewCell", for: indexPath) as! SubScriptionCollectionViewCell
            cell.lblTitle.text = arrPlans[indexPath.row].planName
            cell.lblAmmount.text = "AED \(arrPlans[indexPath.row].price ?? "")"
            let objtitle = arrPlans[indexPath.row].items
            if objtitle?.count != 0 {
                cell.lblPlanTitle1.text = objtitle?[0]
                cell.lblPlanTitle2.text = objtitle?[1]
                cell.lblPlantitle3.text = objtitle?[2]
            }
            cell.viewBG.borderWidth = arrPlans[indexPath.row].selected == true ? 1 : 0
            cell.viewBG.borderColor = arrPlans[indexPath.row].selected == true ? colors.ThemeYellow.value : UIColor.clear
            
//            let objIndex = objSubScriptionPlan?.data[indexPath.row]
//            cell.lblTime.text = objIndex?.duration
//            self.lblDescription.text = objIndex?.descriptionField
//            self.lblTitle.text = objIndex?.planName
//            cell.lblamount.text = "$" + (objIndex?.price ?? "0")
//            self.pageControler.isHidden = objSubScriptionPlan?.data.count != 0 ? false : true
//
//             self.pageControler.numberOfPages = self.objSubScriptionPlan?.data.count == 0 ? 0: self.objSubScriptionPlan?.data.count ?? 0
//             cell.isUserInteractionEnabled = objIndex?.purchasePlan == "1" ? false : true
                           
           // if selectedPlan != nil {
//                cell.viewBG.backgroundColor = objIndex?.isSelected == true ? themeColors.themeColour : UIColor.white
//                cell.lblTime.textColor =  objIndex?.isSelected == true ? UIColor.white : themeColors.DarkTextGray
//                cell.lblamount.textColor =  objIndex?.isSelected == true ? themeColors.lightThemeColour : themeColors.themeColour
                           
//            }
//            else {
//                cell.viewBG.backgroundColor =  objIndex?.purchasePlan == "1"  ? themeColors.themeColour : UIColor.white
//                cell.lblTime.textColor =  objIndex?.purchasePlan == "1" ? UIColor.white : themeColors.DarkTextGray
//                cell.lblamount.textColor =  objIndex?.purchasePlan == "1"  ? themeColors.lightThemeColour : themeColors.themeColour
//
//            }
//
            return cell
        }
        return UICollectionViewCell()
//         else {
//               let NoDatacell = collPlans.dequeueReusableCell(withReuseIdentifier: "NoDataCollectionViewCell", for: indexPath) as! NoDataCollectionViewCell
//               NoDatacell.lblNodataTitle.text = "No Data Found!"
//
//               return NoDatacell
//          }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //if objSubScriptionPlan?.data.count  == 0 {
        return CGSize(width: 189, height: 250)

//        }
//        else {
//            return CGSize(width: 180, height: 220)
//        }
//
      }
    
    
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if arrPlans.count != 0 {
//            selectedIndex = indexPath.row
//            selctedplan = arrPlans[selectedIndex]
//            self.CollectionSubscriptionPlan.reloadData()
//        }
//
        if arrPlans.count != 0 {

            for i in arrPlans{
                i.selected = false
            }

               selectedIndex = selectedIndex == indexPath.row ? -1 : indexPath.row
               print(selectedIndex)
              if selectedIndex != -1 {
                arrPlans[selectedIndex].selected = true
                selctedplan = arrPlans[selectedIndex]
                print(selctedplan)
                print(selectedIndex)
                self.CollectionSubscriptionPlan.reloadItems(at: [IndexPath(item: selectedIndex, section: 0)])
              }
            }
         }
    
    
         func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
               let centerPoint = CGPoint(x: CollectionSubscriptionPlan.bounds.midX, y: CollectionSubscriptionPlan.bounds.midY)

                if let indexPath = CollectionSubscriptionPlan.indexPathForItem(at: centerPoint) {
                    print(indexPath.row)
//                    self.currentPage = indexPath.row
//                    pageControler.setCurrentPage(at: indexPath.row)
//                   selectedPlan = objSubScriptionPlan?.data[indexPath.row]
//                  self.btnUpgradePlan.isUserInteractionEnabled =  objSubScriptionPlan?.data[indexPath.row].purchasePlan == "1" ? false : true
//                  self.btnUpgradePlan.backgroundColor = objSubScriptionPlan?.data[indexPath.row].purchasePlan == "1" ? themeColors.grayColor : themeColors.themeColour
//                  self.btnUpgradePlan.setTitle(objSubScriptionPlan?.data[indexPath.row].purchasePlan == "1" ? "CURRENT PLAN" : "UPDATE PLAN", for: .normal)
                         
                }
        }
    
    
}

//extension SubScriptionPlanVC {
//    func webServiceCallSubscriptionList(){
//        WebServiceSubClass.Shared.SubscriptionPlan(ShowHud: true, Plan: showplan, UserId: SingaltoneClass.sharedInstance.LoginUser?.id ?? "") { (response,
//            Status) in
//            if Status {
//                print(response)
//                let objRes = RootPlans(fromJson: response)
//                self.objSubScriptionPlan = objRes
//                self.pageControler.numberOfPages = objRes.data.count != 0 ?  objRes.data.count : 0
//                if self.objSubScriptionPlan?.data.count != 0 {
//                    self.lblNoData.isHidden = true
//                    self.lblTitle.isHidden = false
//                    self.lblDescription.isHidden = false
//                    self.btnUpgradePlan.isHidden = false
//                    self.collPlans.isHidden = false
//                    self.collPlans.reloadData()
//
//                }
//                else {
//                    self.lblNoData.isHidden = false
//                    self.collPlans.isHidden = true
//                    self.lblTitle.isHidden = true
//                    self.lblDescription.isHidden = true
//                    self.btnUpgradePlan.isHidden = true
//                }
//
//            }
//
//            else{
//                self.showAlert(message: response["message"].stringValue)
//            }
//        }
//    }
//}

extension SubScriptionPlanVC : PKPaymentAuthorizationViewControllerDelegate {
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        dismiss(animated: true, completion: nil)
       // displayDefaultAlert(title: "Success!", message: "The Apple Pay transaction was complete.")

    }
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
    }
}

extension UICollectionView {

var centerPoint : CGPoint {

    get {
        return CGPoint(x: self.center.x + self.contentOffset.x, y: self.center.y + self.contentOffset.y);
    }
}

var centerCellIndexPath: IndexPath? {

    if let centerIndexPath: IndexPath  = self.indexPathForItem(at: self.centerPoint) {
        return centerIndexPath
    }
    return nil
 }
}
