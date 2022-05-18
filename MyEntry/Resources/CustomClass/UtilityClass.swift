//
//  UtilityClass.swift
//  MyLineup
//
//  Created by Mayur iMac on 10/12/19.
//  Copyright © 2019 Mayur iMac. All rights reserved.
//

import Foundation
import  UIKit
//import Kingfisher

enum navigationTitlePosition: String {
    case middle
    case left
}


class UtilityClass : NSObject
{
    
    class func setTitleInNavigationBar(strTitle : String, navigationItem : UINavigationItem, position : navigationTitlePosition = .left, navigationController : UINavigationController , isMenu : Bool)
    {
        guard let NodataFoundView = Bundle.main.loadNibNamed("NavigationView", owner: nil, options: nil)?.first as? NavigationView else { return  }
        
        let longTitleLabel = UILabel()
        longTitleLabel.text = strTitle
        longTitleLabel.font = CustomFont.Medium.returnFont(14.0)
        longTitleLabel.sizeToFit()
        
        if(position == .left)
        {
            let leftItem = UIBarButtonItem(customView: NodataFoundView)
            navigationItem.leftBarButtonItem = leftItem
        }
    
        else
        {
            longTitleLabel.font = CustomFont.Medium.returnFont(14.0)
            longTitleLabel.textAlignment = .center
            navigationItem.titleView = longTitleLabel
        }

    }
//    
//    class func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
//        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
//        label.numberOfLines = 0
//        label.lineBreakMode = NSLineBreakMode.byWordWrapping
//        label.font = font
//        label.text = text
//
//        label.sizeToFit()
//        return label.frame.height
//    }
    
    class func CheckContact(Title : String,currentVC:UIViewController){
              
              let alertController = UIAlertController(title: Title, message: "Please allow the app to access your contacts through the Settings.", preferredStyle: .alert)
              let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
              let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                  
                  guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                      return
                  }
                  
                  if UIApplication.shared.canOpenURL(settingsUrl) {
                      UIApplication.shared.open(settingsUrl, completionHandler: { (success)
                          in
                          print("Settings opened: \(success)") // Prints true
                      })
                  }
              }
              alertController.addAction(settingsAction)
              
              alertController.addAction(OKAction)
              OperationQueue.main.addOperation {
                  currentVC.present(alertController, animated: true,
                                    completion:nil)
              }
              
          }
       

    class func alert(withTitle title: String?, message: String?, buttons buttonArray: [Any]?, completion block: @escaping (_ buttonIndex: Int) -> Void) {

        let strTitle = title

        let alertController = UIAlertController(title: strTitle, message: message, preferredStyle: .alert)
        for buttonTitle in buttonArray ?? [] {
            guard let buttonTitle = buttonTitle as? String else {
                continue
            }
            var action: UIAlertAction?
            if (buttonTitle.lowercased() == "cancel") {
                action = UIAlertAction(title: buttonTitle, style: .destructive, handler: { action in
                    let index = (buttonArray as NSArray?)?.index(of: action.title ?? "")
                    block(index!)
                })
            } else {
                action = UIAlertAction(title: buttonTitle, style: .default, handler: { action in
                    let index = (buttonArray as NSArray?)?.index(of: action.title ?? "")
                    block(index!)
                })
            }

            if let action = action {
                alertController.addAction(action)
            }
        }
        self.topMostController()?.present(alertController, animated: true)

    }
    
    
    class func getMessageFromApiResponse(param: Any) -> String {
        
        if let res = param as? String {
            return res
            
        }else if let resDict = param as? NSDictionary {
            
            if let msg = resDict.object(forKey: "message") as? String {
                return msg
                
            }else if let msg = resDict.object(forKey: "msg") as? String {
                return msg
                
            }else if let msg = resDict.object(forKey: "message") as? [String] {
                return msg.first ?? ""
                
            }
            
        }else if let resAry = param as? NSArray {
            
            if let dictIndxZero = resAry.firstObject as? NSDictionary {
                if let msg = dictIndxZero.object(forKey: "message") as? String {
                    return msg
                    
                }else if let msg = dictIndxZero.object(forKey: "msg") as? String {
                    return msg
                    
                }else if let msg = dictIndxZero.object(forKey: "message") as? [String] {
                    return msg.first ?? ""
                }
                
            }else if let msg = resAry as? [String] {
                return msg.first ?? ""
                
            }
        }
        return ""
    }
    
    class func showNoDataFound(text:String,View:UIView) {
           let label = UILabel(frame: CGRect(x:UIScreen.main.bounds.width/2 - 120,y:UIScreen.main.bounds.height/2 - 25,width:240,height: 50))
           label.textAlignment = .center
           label.textColor = .black
          // label.backgroundColor = .yellow
          label.font = CustomFont.Bold.returnFont(20.0)
           label.text =  text
           View.addSubview(label)
       }
//    class func imageGet(url : String , img:UIImageView , _ IndClr : UIColor = colors.ThemeYellow.value){
//         img.kf.indicatorType = .activity
//         let activity =  img.kf.indicator?.view as! UIActivityIndicatorView
//        activity.color = colors.ThemeYellow.value
//         
//         img.kf.indicator?.startAnimatingView()
//         let url = URL(string:(url))
//         img.kf.setImage(with: url, placeholder: nil, options: [], progressBlock: nil) { (response) in
//            
//             img.kf.indicator?.stopAnimatingView()
//         }
//     }
//    
//       


    
   class func OkalerwithAction(Msg:String , Btnaction : @escaping()->()){
    let alertController = UIAlertController(title: Constant.AppName, message: Msg, preferredStyle: .alert)
         let okaction = UIAlertAction.init(title: "OK", style: .default) { (action) in
            Btnaction()
         }
         alertController.addAction(okaction)
      self.topMostController()?.present(alertController, animated: true)
     }
    
    class func topMostController() -> UIViewController? {
        var topController = UIApplication.shared.keyWindow?.rootViewController

        while ((topController?.presentedViewController) != nil) {
            topController = topController?.presentedViewController
        }

        return topController
    }
    
    // Error Message Show
    class func defaultMsg(result:Any) -> String {
         if let res = result as? String {
            
            return res
        }
         else if let resDict = result as? [String:AnyObject]{
            if let message = resDict["message"] as? String {
                return message
            }
            else if let msg = resDict["message"] as? [String]{
                return msg.joined(separator: "\n")
            }
        }
        else if let resAry = result as? [[String:Any]] {
            if let message = resAry[0]["message"] as? String{
                return message
            }
        }
         
        return ""
    }
    
    class func isValidEmail(testStr:String) -> Bool {
         
          let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
          
          let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
          return emailPred.evaluate(with: testStr)
    }
    
    class func ChangeBtnColour(Btn : UIButton,textfields : [UITextField] , EnableColour : UIColor , DisableColour : UIColor){
        for i in 0..<textfields.count{
            if textfields[i].text == ""{
                Btn.backgroundColor = DisableColour
                Btn.isUserInteractionEnabled = false
            }
            else{
                Btn.backgroundColor = EnableColour
                Btn.isUserInteractionEnabled = true

            }
        }
    }
    
    
    class func btnStateChanges(Btn:UIButton,EnableColour : UIColor ,DisableColour : UIColor , isEnable : Bool){
        
            Btn.backgroundColor = DisableColour
            Btn.isUserInteractionEnabled = isEnable
            Btn.backgroundColor = EnableColour
    }
    
    
    //MARK:- Date string format change ========
       class func getDateTimeString(dateString:String)-> String{
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"                 // Note: S is fractional second
           let dateFromString = dateFormatter.date(from: dateString)      // "Nov 25, 2015, 4:31 AM" as NSDate
           
           let dateFormatter2 = DateFormatter()
           dateFormatter2.dateFormat = StrdateFormatter.DateMonth.rawValue
           
           let stringFromDate = dateFormatter2.string(from: dateFromString!) // "Nov 25, 2015" as String
           return stringFromDate
       }
    
    
    class func getDateString(dateString:String)-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = StrdateFormatter.StrYMD.rawValue                  // Note: S is fractional second
        let dateFromString = dateFormatter.date(from: dateString)      // "Nov 25, 2015, 4:31 AM" as NSDate
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = StrdateFormatter.strMD.rawValue
        
        let stringFromDate = dateFormatter2.string(from: dateFromString!) // "Nov 25, 2015" as String
        return stringFromDate
    }
       
       
       //MARK:- Date string format change ========
       class func DateStringChange(Format:String,getFormat:String,dateString:String)-> String{
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = Format                // Note: S is fractional second
           let dateFromString = dateFormatter.date(from: dateString)      // "Nov 25, 2015, 4:31 AM" as NSDate
           
           let dateFormatter2 = DateFormatter()
           dateFormatter2.dateFormat =  getFormat//"MMM d, yyyy h:mm a"
           
           let stringFromDate = dateFormatter2.string(from: dateFromString! ) // "Nov 25, 2015" as String
           return stringFromDate
       }
       
       
      class func attributedText(withString string: String, boldString: String, font: UIFont) -> NSAttributedString {
           let attributedString = NSMutableAttributedString(string: string,
                                                        attributes: [NSAttributedString.Key.font: font])
           let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: font.pointSize)]
           let range = (string as NSString).range(of: boldString)
           attributedString.addAttributes(boldFontAttribute, range: range)
           return attributedString
       }
    
//    class func showCustomloader(view:UIView , ishide : Bool){
//         let ind = MyIndicator(frame: CGRect(x: windowWidth/2 - 25, y: windowHeight/2 - 25, width:Constant.loaderWidth, height: Constant.loaderheight), image: UIImage(named:Constant.Loaderimage) ?? UIImage())
//
//        if ishide {
//            ind.stopAnimating()
//            ind.removeFromSuperview()
//        }
//        else{
//            view.addSubview(ind)
//            ind.startAnimating()
//        }
//     }
   
}
//public func formattedNumber(number: String, mask:String) -> String {
//    let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
//    var result = ""
//    var index = cleanPhoneNumber.startIndex
//    for ch in mask where index < cleanPhoneNumber.endIndex {
//        if ch == "X" {
//            result.append(cleanPhoneNumber[index])
//            index = cleanPhoneNumber.index(after: index)
//        } else {
//            result.append(ch)
//        }
//    }
//    return result
//}

func formattedNumber(number: String) -> String {
    let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    let mask = "(XXX) XXX-XXXX"
    //"+X (XXX) XXX-XXXX"

    var result = ""
    var index = cleanPhoneNumber.startIndex
    for ch in mask where index < cleanPhoneNumber.endIndex {
        if ch == "X" {
            result.append(cleanPhoneNumber[index])
            index = cleanPhoneNumber.index(after: index)
        } else {
            result.append(ch)
        }
    }
    return result
}

enum StrdateFormatter : String{
    case DateMonth = "MMM d, yyyy"
    case StrYMD  = "yyyy-MM-dd"
    case strMD = "MMM d"
    case strDMY = "dd MMM yyyy"
}


extension String {

    var length : Int {
        return self.count
    }

    func digitsOnly() -> String{
        let stringArray = self.components(separatedBy: NSCharacterSet.decimalDigits.inverted)
        let newString = stringArray.joined(separator: "")

        return newString
    }

}

extension UIApplication {
    class func appTopViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return appTopViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return appTopViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return appTopViewController(controller: presented)
        }
        return controller
    }
}
