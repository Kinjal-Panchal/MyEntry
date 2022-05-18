////
////  CustomLabel.swift
////  SecondNile
////
////  Created by panchal kinjal on 17/07/21.
////
//
import Foundation
import UIKit

//MARK :- Title label and Info Title label
class ThemTitleLabel : UILabel {
    
    @IBInspectable var Colour : UIColor = colors.ThemeGray.value
    @IBInspectable var isLight : Bool = false
    @IBInspectable var isRegular : Bool = false
    @IBInspectable var isBold : Bool = false
    @IBInspectable var size:CGFloat = 24.0
    @IBInspectable var isSize : Bool = false
    @IBInspectable var isSemibold : Bool = false
    @IBInspectable var ThemeBtnTitleLabel : Bool = false
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if Colour != colors.ThemeGray.value {
            self.textColor = Colour
        }
        else{
            self.textColor = ThemeBtnTitleLabel == true ? UIColor(hexString: "#4F4F4F") : colors.ThemeGray.value
        }
        
        if isRegular == true {
            self.font = ThemeBtnTitleLabel == true ? CustomFont.Regular.returnFont(isSize == true ? size : 16.0) : CustomFont.Regular.returnFont(isSize == true ? size : 32.0)
        }
        else if isSemibold  == true {
            CustomFont.SemiBold.returnFont(isSize == true ? size : 24.0)
            
        }
        else if isLight  == true {
            CustomFont.Light.returnFont(isSize == true ? size : 13.0)
            
        }
        else if isBold  == true {
            CustomFont.Bold.returnFont(isSize == true ? size : 24.0)
            
        }
        else {
            self.font = ThemeBtnTitleLabel == true ? CustomFont.Medium.returnFont(isSize == true ? size : 16.0) : CustomFont.Medium.returnFont(isSize == true ? size : 32.0)
        }
       
    }

}

class ThemeWhiteLabel : UILabel {
    
    @IBInspectable var size:CGFloat = 32.0
    @IBInspectable var isSize : Bool = false
    @IBInspectable var isRegular : Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textColor = UIColor.white
            self.font = isRegular == true ? CustomFont.Regular.returnFont(isSize == true ? size : 32.0) : CustomFont.Medium.returnFont(isSize == true ? size : 32.0)
    }
}
class themeORLabel : UILabel{
    
    @IBInspectable var isVerify : Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if isVerify {
            self.textColor =  colors.ThemeGray.value
            self.font = CustomFont.Medium.returnFont(14.0)
        }
        else {
            self.textColor = UIColor(hexString: "#333333")
            self.font = CustomFont.Medium.returnFont(15.0)
        }
    }
}
//
//class ThemeBlackLabl500 : UILabel {
//
//    @IBInspectable var isSize : Bool = false
//    @IBInspectable var size : CGFloat = FontSize.size14.rawValue
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//        self.font = CustomFont.MuseoSans_500.returnFont(isSize == false ? FontSize.size16.rawValue : size)
//            self.textColor = colors.black.value
//        }
//}
//
//
//
//class ThemeBluel700 : UILabel {
//
//    @IBInspectable var isSize : Bool = false
//    @IBInspectable var size : CGFloat = FontSize.size14.rawValue
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//        self.font = CustomFont.MuseoSans_700.returnFont(isSize == false ? FontSize.size18.rawValue : size)
//            self.textColor = colors.ThemeDarkBlue.value
//        }
//}
//
//
//class ThemeBlackLabel700 : UILabel {
//
//    @IBInspectable var fontStyle300 : Bool = false
//    @IBInspectable var isSize : Bool = false
//    @IBInspectable var size : CGFloat = FontSize.size14.rawValue
//    @IBInspectable var isBlackLight : Bool  = false
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//
//        if fontStyle300 == true {
//            self.font =   CustomFont.MuseoSans_300.returnFont(isSize == false ? FontSize.size16.rawValue : size)
//                self.textColor = colors.black.value
//        }
//        else if isBlackLight == true {
//            self.font =   CustomFont.MuseoSans_700.returnFont(FontSize.size20.rawValue)
//            self.textColor = UIColor.hexStringToUIColor(hex: "#2D3254")
//        }
//        else {
//            self.font =   CustomFont.MuseoSans_700.returnFont(isSize == false ? FontSize.size16.rawValue : size)
//                self.textColor = colors.black.value
//        }
//
//        }
//
//}
//
//class ThemDateLabel : UILabel {
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        self.textColor = colors.ThemeLightDateText.value
//        self.font = CustomFont.MuseoSans_500.returnFont(FontSize.size14.rawValue)
//    }
//}
//
//
////MARK:- =====
//class themeMenuLabel : UILabel {
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        self.textColor = UIColor.hexStringToUIColor(hex: "#747474")
//        self.font = CustomFont.MuseoSans_500.returnFont(FontSize.size16.rawValue)
//    }
//}
//
//class ThemGreenLabel : UILabel {
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//        self.font = CustomFont.MuseoSans_300.returnFont(FontSize.size14.rawValue)
//        self.textColor = UIColor.hexStringToUIColor(hex: "#23CB55")
//
//    }
//}
//
//class ThemLightGrayLabel : UILabel {
//
//    @IBInspectable var isSize : Bool = false
//    @IBInspectable var isDark : Bool = false
//    @IBInspectable var Size : CGFloat = 0.0
//    @IBInspectable var is70StyleGray:Bool = false
//    @IBInspectable var is75StyleGray:Bool = false
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//        if isDark == true {
//            self.textColor = UIColor.hexStringToUIColor(hex: "#646464")
//            self.font = CustomFont.MuseoSans_700.returnFont(isSize == true ? Size : FontSize.size18.rawValue)
//        }
//        else if is70StyleGray == true {
//            self.textColor = UIColor.hexStringToUIColor(hex: "#707070")
//            self.font = CustomFont.MuseoSans_700.returnFont(isSize == true ? Size : FontSize.size20.rawValue)
//        }
//        else if is75StyleGray == true {
//            self.textColor = UIColor.hexStringToUIColor(hex: "#757575")
//            self.font = CustomFont.MuseoSans_300.returnFont(isSize == true ? Size : FontSize.size12.rawValue)
//        }
//        else {
//
//            self.textColor = UIColor.hexStringToUIColor(hex: "#969696")
//            self.font = CustomFont.MuseoSans_700.returnFont(isSize == true ? Size : FontSize.size16.rawValue)
//        }
//
//    }
//}
//
//class HomeThemeDarkgray : UILabel {
//
//    @IBInspectable var Size : CGFloat = 12.0
//    @IBInspectable var isLight:Bool = false
//    @IBInspectable var isSize : Bool = false
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//        if isLight == true {
//            self.textColor = UIColor.hexStringToUIColor(hex: "#8D8D8D")
//            self.font = CustomFont.MuseoSans_300.returnFont(isSize == true ? Size : FontSize.size12.rawValue)
//        }
//        else {
//            self.textColor = UIColor.hexStringToUIColor(hex: "#585858")
//            self.font = CustomFont.MuseoSans_300.returnFont(isSize == true ? Size : FontSize.size14.rawValue)
//        }
//}
//}
//
//class HomeThemeWhiteLabel : UILabel {
//
//    @IBInspectable var isStyleFont500 : Bool = false
//    @IBInspectable var isNavTitle : Bool = false
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        if isStyleFont500 == true {
//            self.font = isNavTitle == true ? CustomFont.MuseoSans_500.returnFont(18.0) : CustomFont.MuseoSans_500.returnFont(19.0)
//        }
//        else {
//            self.font = CustomFont.MuseoSans_700.returnFont(33.0)
//        }
//    }
//}
//
//class ThemeAboutLabel : UILabel {
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        self.font = CustomFont.MuseoSans_300.returnFont(14.0)
//        self.textColor = UIColor.hexStringToUIColor(hex: "#8D8D8D")
//    }
//}
