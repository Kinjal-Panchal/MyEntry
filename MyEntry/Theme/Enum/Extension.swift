//
//  Extension.swift
//  Oppera
//
//  Created by EWW077 on 18/04/1941 Saka.
//  Copyright © 1941 eww090. All rights reserved.
//

import Foundation
import UIKit

//import Alamofire
//import SwiftyJSON

let windowWidth: CGFloat = CGFloat(UIScreen.main.bounds.size.width)
let windowHeight: CGFloat = CGFloat(UIScreen.main.bounds.size.height)
let screenHeightDeveloper : Double = 568
let screenWidthDeveloper : Double = 320
var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)

public enum Model : String {
    case simulator   = "simulator/sandbox",
    iPhone5          = "iPhone 5",
    iPhone5S         = "iPhone 5S",
    iPhone5C         = "iPhone 5C",
    iPhone6          = "iPhone 6",
    iPhone6plus      = "iPhone 6 Plus",
    iPhone6S         = "iPhone 6S",
    iPhone6Splus     = "iPhone 6S Plus",
    iPhoneSE         = "iPhone SE",
    iPhone7          = "iPhone 7",
    iPhone7plus      = "iPhone 7 Plus",
    iPhone8          = "iPhone 8",
    iPhone8plus      = "iPhone 8 Plus",
    iPhoneX          = "iPhone X",
    iPhoneXS         = "iPhone XS",
    iPhoneXSmax      = "iPhone XS Max",
    iPhoneXR         = "iPhone XR",
    unrecognized     = "?unrecognized?"
}

enum AppStoryboard: String {
    case main = "Main"
    case Auth = "Auth"
    case Table = "TableModule"
    //case Event = "EventModule" // this might not required as previous reference still in main

}

extension UIViewController {

    class func instantiate<T: UIViewController>(appStoryboard: AppStoryboard) -> T {

        let storyboard = UIStoryboard(name: appStoryboard.rawValue, bundle: nil)
        let identifier = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }

    func setNavBarWithMenuORBack(Title:String,LetfBtn : String, IsNeedRightButton:Bool , RightButton : String,isTranslucent : Bool , barTinColour : UIColor = colors.ThemeYellow.value)
    {

        self.navigationItem.title = Title//.uppercased()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isOpaque = false
        self.navigationController?.navigationBar.barTintColor = barTinColour
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationController?.navigationBar.isTranslucent = isTranslucent
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white , NSAttributedString.Key.font : CustomFont.Medium.returnFont(FontSize.size18.rawValue)]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

    }
}

extension UIView{

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }

    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    @IBInspectable
    var ShadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

extension UIView{

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    @discardableResult
    func addLineDashedStroke(pattern: [NSNumber]?, radius: CGFloat, color: CGColor) -> CALayer {
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = color
        borderLayer.lineDashPattern = pattern
        borderLayer.frame = bounds
        borderLayer.fillColor = nil
        borderLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius)).cgPath

        layer.addSublayer(borderLayer)
        return borderLayer
    }
}


//MARK:- ==== storyboard identifier ======
extension UIStoryboard {
    func instantiate<T>() -> T {
        return instantiateViewController(withIdentifier: String(describing: T.self)) as! T
    }
    
    static let main = UIStoryboard(name: AppStoryboard.main.rawValue, bundle: nil)
}
//MARK:- ==== Extension viewcontroller for identifier ======
//extension UIViewController {
//
//    class func instantiateVC<T: UIViewController>() -> T {
//
//        let storyboard = UIStoryboard(name: UIStoryboard.main.instantiate(), bundle: nil)
//        //let identifier = String(describing: self)
//        return storyboard.instantiateViewController(withIdentifier: UIStoryboard.main.instantiate()) as! T
//    }
//}


func getDevice() -> Model
{
    if UIDevice().userInterfaceIdiom == .phone {
        switch UIScreen.main.nativeBounds.height {
        case 1136:
            return Model.iPhone5
        //            print("iPhone 5 or 5S or 5C")
        case 1334:
            return Model.iPhone6
            
        //            print("iPhone 6/6S/7/8")
        case 1920, 2208:
            print("iPhone 6+/6S+/7+/8+")
        case 2436:
            return Model.iPhoneX
            
        //            print("iPhone X, Xs")
        case 2688:
            return Model.iPhoneXSmax
            
        //            print("iPhone Xs Max")
        case 1792:
            return Model.iPhoneXR
        //            print("iPhone Xr")
        default:
            print("unknown")
        }
    }
    return Model.unrecognized
}


extension UIColor {
    
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        print("hex value is not valid")
        return nil
    }
    class func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
extension UITextField {
    
    enum Direction {
        case Left
        case Right
    }
    
    // add image to textfield
    func withImage(direction: Direction, image: UIImage, colorSeparator: UIColor, colorBorder: UIColor){
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 45))
        mainView.layer.cornerRadius = 5
        mainView.backgroundColor = UIColor.clear
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 45))
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.layer.borderWidth = CGFloat(0.5)
        view.layer.borderColor = colorBorder.cgColor
        view.backgroundColor = UIColor.clear
        mainView.addSubview(view)
        
        let imageView = UIImageView(image: image)
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 12.0, y: 10.0, width: 24.0, height: 24.0)
        view.addSubview(imageView)
        
        let seperatorView = UIView()
        seperatorView.backgroundColor = colorSeparator
        mainView.addSubview(seperatorView)
        
        if(Direction.Left == direction){ // image left
            seperatorView.frame = CGRect(x: 45, y: 0, width: 5, height: 45)
            self.leftViewMode = .always
            self.leftView = mainView
        } else { // image right
            seperatorView.frame = CGRect(x: 0, y: 0, width: 5, height: 45)
            self.rightViewMode = .always
            self.rightView = mainView
        }
        
        self.layer.borderColor = colorBorder.cgColor
        self.layer.borderWidth = CGFloat(0.5)
        self.layer.cornerRadius = 5
    }
    
    func placeholderColour(Colour : UIColor , PlaceHolder : String){
        var placeholderColor: UIColor = Colour
        let attributes = [ NSAttributedString.Key.foregroundColor: placeholderColor]
        attributedPlaceholder = NSAttributedString(string: PlaceHolder ?? "", attributes: attributes)
    }
    
   
        
    
}
extension UIViewController  {
    func showAlert(message: String) -> Void {
        let alertController = UIAlertController.init(title:Constant.AppName, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func isPasswordValid(_ password : String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
        func popupAlert(title: String?, message: String?, actionTitles:[String?], actions:[((UIAlertAction) -> Void)?]) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            for (index, title) in actionTitles.enumerated() {
                let action = UIAlertAction(title: title, style: .default, handler: actions[index])
                alert.addAction(action)
            }
            self.present(alert, animated: true, completion: nil)
        }
    
    
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
extension String {
    func isEmptyOrWhitespace() -> Bool {
            if(self.isEmpty) {
                return true
            }
            return self.trimmingCharacters(in: (.whitespaces)).isEmpty
        }
    
     func trim() -> String {
        
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
        
    }
    
    func isStringLink() -> Bool {
        let types: NSTextCheckingResult.CheckingType = [.link]
        let detector = try? NSDataDetector(types: types.rawValue)
        guard (detector != nil && self.count > 0) else { return false }
        if detector!.numberOfMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) > 0 {
            return true
        }
        return false
    }
    
    
//    Gold
//    Blue
//    Brown
//    Green
//    White
//    Gray
//    Red
//    Black
//    Silver
//    Copper
    
    func colorFromstring() -> UIColor {
           switch self {
           case "black" :
               return UIColor.black
           case "white":
               return UIColor.white
           case "red" :
               return UIColor.red
           case "blue" :
               return UIColor.blue
           case "gray" :
                return UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
           case "silver" :
               return UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1)
           case "green" :
               return UIColor.green
           case "brown" :
                return UIColor(red: 165/255, green: 42/255, blue: 42/255, alpha: 1)
           case "teal" :
               return UIColor(red: 0/255, green: 128/255, blue: 129/255, alpha: 1)
           case "yellow" :
               return UIColor.yellow
           case "gold" :
               return UIColor(red: 255/255, green: 215/255, blue: 0/255, alpha: 1)
           case "copper" :
               return UIColor(red: 188/255, green: 115/255, blue: 50/255, alpha: 1)
           default:
               break
           }
           return UIColor.clear
       }
    
    
    func toImage() -> UIImage? {
        if let url = URL(string: self),let data = try? Data(contentsOf: url),let image = UIImage(data: data) {
            return image
        }
            
        else  if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
   
}

extension NSMutableAttributedString {
    
    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        
        // Swift 4.2 and above
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        
    }
    
}
extension UIImage {
    
    func fixedOrientation() -> UIImage? {
        
        guard imageOrientation != UIImage.Orientation.up else {
            //This is default orientation, don't need to do anything
            return self.copy() as? UIImage
        }
        
        guard let cgImage = self.cgImage else {
            //CGImage is not available
            return nil
        }
        
        guard let colorSpace = cgImage.colorSpace, let ctx = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
            return nil //Not able to create CGContext
        }
        
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat.pi)
            break
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: CGFloat.pi / 2.0)
            break
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: CGFloat.pi / -2.0)
            break
        case .up, .upMirrored:
            break
        }
        
        //Flip image one more time if needed to, this is to prevent flipped image
        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform.translatedBy(x: size.width, y: 0)
            transform.scaledBy(x: -1, y: 1)
            break
        case .leftMirrored, .rightMirrored:
            transform.translatedBy(x: size.height, y: 0)
            transform.scaledBy(x: -1, y: 1)
        case .up, .down, .left, .right:
            break
        }
        
        ctx.concatenate(transform)
        
        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
        default:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            break
        }
        
        guard let newCGImage = ctx.makeImage() else { return nil }
        return UIImage.init(cgImage: newCGImage, scale: 1, orientation: .up)
    }
    
    
}



//extension UIViewController {
//
//    func setNavBarWithMenuORBack(Title:String,LetfBtn : String, IsNeedRightButton:Bool , RightButton : String,isTranslucent : Bool)
//    {
//       
//            self.navigationItem.title = Title//.uppercased()
//        self.navigationController?.isNavigationBarHidden = false
//        //    self.navigationController?.navigationBar.isOpaque = false
//        self.navigationController?.navigationBar.barTintColor = ThemeGreenColor
//        self.navigationController?.navigationBar.tintColor = UIColor.white;
//        self.navigationController?.navigationBar.isTranslucent = isTranslucent
//        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//       
//        if LetfBtn == "Back"{
//            isFromBtnClickBack = true
//            if let BackBtnNotClick = isBackBtnClick{
//                BackBtnNotClick(false)
//            }
//            
//            isBackBtnClick = {(value) in
//              print(value)
//                delegateSocketCall = {(HoleId) in
//        
////                        let param = [
////
////                            socketApiKeys.KUserId : SingaltoneClass.sharedInstance.LoginData.iD  ?? ""as Any,
////                            socketApiKeys.KGameId : SingaltoneClass.sharedInstance.GameData?.iD ?? ""as Any,
////                            socketApiKeys.KHoleId : HoleId
////
////                            ] as [String : Any]
////
////                        SocketIOManager.shared.socketEmit(for: socketApiKeys.KAnamuleUpdateComplete, with: param)
//                   
//                    
//                  
//                           let param = [
//                                      
//                                  socketApiKeys.KUserId : SingaltoneClass.sharedInstance.LoginData.iD  ?? ""as Any,
//                                  socketApiKeys.KGameId : SingaltoneClass.sharedInstance.GameData?.iD ?? ""as Any,
//                                   socketApiKeys.KHoleId : HoleId
//                                  
//                                  ] as [String : Any]
//                              SocketIOManager.shared.socketEmit(for: socketApiKeys.KCancelAnamuleUpdate, with: param)
//                }
//            }
//            
//        }
//        
//        if IsNeedRightButton == true
//        {
//            if RightButton == IconMenu.RightIcon {
//                
//                let button = UIButton(type: UIButton.ButtonType.custom)
//                button.setImage(UIImage(named: RightButton), for:.normal)
//                button.addTarget(self, action: #selector(RightBtnAction), for:.touchUpInside)
//                button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//                let barButton = UIBarButtonItem(customView: button)
//                self.navigationItem.rightBarButtonItem = nil
//                self.navigationItem.rightBarButtonItem = barButton
//            }
//                
//          else  if RightButton == IconMenu.RefreshIcon {
//                
//                let button = UIButton(type: UIButton.ButtonType.custom)
//                button.setImage(UIImage(named: RightButton), for:.normal)
//                button.addTarget(self, action: #selector(RefreshBtnAction), for:.touchUpInside)
//                button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//                let barButton = UIBarButtonItem(customView: button)
//                self.navigationItem.rightBarButtonItem = nil
//                self.navigationItem.rightBarButtonItem = barButton
//            }
//            else
//            {
//                let button = UIButton(type: UIButton.ButtonType.custom)
//                button.setImage(UIImage(named: RightButton), for:.normal)
//                button.addTarget(self, action: #selector(RightBtnSyncAction), for:.touchUpInside)
//                button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//                let barButton = UIBarButtonItem(customView: button)
//                self.navigationItem.rightBarButtonItem = nil
//                self.navigationItem.rightBarButtonItem = barButton
//            }
//        }
//    }
//    
//    
//    // MARK:- Navigation Bar Button Action Methods
//    
//    @objc func RightBtnAction(){
//        self.dismiss(animated: true, completion: nil)
//    }
//    @objc func LeftBtnAction(){
//    
//    }
//    
//    @objc func RefreshBtnAction(){
//      
//
//        
//    }
//    
//
//    @objc func RightBtnSyncAction(){
//        self.dismiss(animated: true, completion: nil)
//    }
//    @objc func btnBackAction()
//    {
//        self.navigationController?.popViewController(animated: true)
//    }
//    
//    
//    }

// MARK: EXTENSION
extension UIViewController {
    
    
    enum AlertButton: Int {
        case confirm
        case cancel
    }
    
    
    func showAlertWithTwoButtonCompletion(title:String, Message:String, defaultButtonTitle:String, cancelButtonTitle : String? = "",  completionHandler: ((AlertButton) -> Void)? = nil) -> Void{
        
        let alertController = UIAlertController(title: title , message:Message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: defaultButtonTitle, style: .default) { (UIAlertAction) in
            if let completionHandler = completionHandler {
                completionHandler(AlertButton.confirm)
            }
        }
        if cancelButtonTitle != ""{
            let CancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel) { (UIAlertAction) in
                if let completionHandler = completionHandler {
                    completionHandler(AlertButton.cancel)
                }
            }
            alertController.addAction(OKAction)
            alertController.addAction(CancelAction)
        }else{
            alertController.addAction(OKAction)
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: IS SWIPABLE - FUNCTION
    func isSwipable(view:UIView) {
         //self.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(onDrage(_:))))
         view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerHandler(_:))))
        
        //self.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    func isDragDown(view:UIView){
        let slideDown = UISwipeGestureRecognizer(target: self, action: #selector(dismissView(gesture:)))
        slideDown.direction = .down
        view.addGestureRecognizer(slideDown)
    }
    
    @objc func dismissView(gesture: UISwipeGestureRecognizer) {
        UIView.animate(withDuration: 0.1) {
           // self.dismiss(animated: true, completion: nil)
            if let theWindow = UIApplication.shared.keyWindow {
                gesture.view?.frame = CGRect(x:theWindow.frame.width - 15 , y: theWindow.frame.height - 15, width: 10 , height: 10)
            }
        }
    }
    
  
    // MARK:  swipe down to hide - FUNCTION
    
    
    @objc func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: self.view?.window)
        
        if sender.state == UIGestureRecognizer.State.began {
            initialTouchPoint = touchPoint
        } else if sender.state == UIGestureRecognizer.State.changed {
            if touchPoint.y - initialTouchPoint.y > 0 {
                print(">0",touchPoint)
                self.view.frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        } else if sender.state == UIGestureRecognizer.State.ended || sender.state == UIGestureRecognizer.State.cancelled {
            if touchPoint.y - initialTouchPoint.y > 100 {
                print(">100",touchPoint)
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                })
            }
        }
    }
    
    
   
    // MARK: HANDLE PAN GESTURE - FUNCTION
   
    @objc func onDrage(_ sender:UIPanGestureRecognizer) {
            let percentThreshold:CGFloat = 0.3
            let translation = sender.translation(in: view)
            
            let newX = ensureRange(value: view.frame.minX + translation.x, minimum: 0, maximum: view.frame.maxX)
            let progress = progressAlongAxis(newX, view.bounds.width)
            
            view.frame.origin.x = newX //Move view to new position
            
            if sender.state == .ended {
                let velocity = sender.velocity(in: view)
                if velocity.x >= 300 || progress > percentThreshold {
                    self.dismiss(animated: true) //Perform dismiss
                } else {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.view.frame.origin.x = 0 // Revert animation
                    })
                }
            }
            
            sender.setTranslation(.zero, in: view)
        }
    
    func progressAlongAxis(_ pointOnAxis: CGFloat, _ axisLength: CGFloat) -> CGFloat {
        let movementOnAxis = pointOnAxis / axisLength
        let positiveMovementOnAxis = fmaxf(Float(movementOnAxis), 0.0)
        let positiveMovementOnAxisPercent = fminf(positiveMovementOnAxis, 1.0)
        return CGFloat(positiveMovementOnAxisPercent)
    }
    
    func ensureRange<T>(value: T, minimum: T, maximum: T) -> T where T : Comparable {
        return min(max(value, minimum), maximum)
    }
    }

//extension String {
//    
//    // Checks if the `String` is a valid email address.
//    func isValidEmailAddress() -> Bool {
//        let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}"
//            + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
//            + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
//            + "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
//            + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
//            + "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
//            + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
//        
//        let emailTest = NSPredicate(format: "SELF MATCHES[c] %@", emailRegEx)
//        return emailTest.evaluate(with: self)
//    }
//}
//

extension UILabel {
        func myLabel() {
            textAlignment = .center
            textColor = .white
            backgroundColor = .lightGray
            font = UIFont.systemFont(ofSize: 17)
            numberOfLines = 0
            lineBreakMode = .byCharWrapping
            sizeToFit()
    }
}

extension Encodable {
    var convertToString: String? {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try jsonEncoder.encode(self)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            return nil
        }
    }
}

extension UIColor {
    convenience init(hexString: String) {
           let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
           var int = UInt64()
           Scanner(string: hex).scanHexInt64(&int)
           let a, r, g, b: UInt64
           switch hex.count {
           case 3: // RGB (12-bit)
               (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
           case 6: // RGB (24-bit)
               (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
           case 8: // ARGB (32-bit)
               (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
           default:
               (a, r, g, b) = (255, 0, 0, 0)
           }
           self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
       }
}

extension UIButton {
    func addRightIcon(image: UIImage) {
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)

        let length = CGFloat(15)
        titleEdgeInsets.right += length

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.titleLabel!.trailingAnchor, constant: 10),
            imageView.centerYAnchor.constraint(equalTo: self.titleLabel!.centerYAnchor, constant: 0),
            imageView.widthAnchor.constraint(equalToConstant: length),
            imageView.heightAnchor.constraint(equalToConstant: length)
        ])
    }
}

extension Double {
    func getDateStringFromUTC() -> String {
        let date = Date(timeIntervalSince1970: self)

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "mm/dd/YYYY"
        
//        let dayTimePeriodFormatter = NSDateFormatter()
//        dayTimePeriodFormatter.dateFormat = "MMM dd YYYY hh:mm a"
//
//         let dateString = dayTimePeriodFormatter.stringFromDate(date)

        return dateFormatter.string(from: date)
    }
}

extension String {
    func fromUTCToLocalDateTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        var formattedString = self.replacingOccurrences(of: "Z", with: "")
        if let lowerBound = formattedString.range(of: ".")?.lowerBound {
            formattedString = "\(formattedString[..<lowerBound])"
        }

        guard let date = dateFormatter.date(from: formattedString) else {
            return self
        }

        dateFormatter.dateFormat = "EEE, MMM d, yyyy - h:mm a"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: date)
    }
}
