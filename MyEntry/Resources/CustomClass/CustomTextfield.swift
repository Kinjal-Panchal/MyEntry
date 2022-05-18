////
////  CustomTextfield.swift
////  SecondNile
////
////  Created by panchal kinjal on 17/07/21.
////
//
import Foundation
import UIKit
import SkyFloatingLabelTextField



class ThemeTextfield : UITextField {

    @IBInspectable var isPrice : Bool = false
    @IBInspectable var image: UIImage? {
        didSet
        {
            setRightViewDropDown(image: image ?? UIImage())
        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [
            .foregroundColor: isPrice == true ? UIColor.hexStringToUIColor(hex: "#828282") :colors.ThemeGray.value,
            .font: CustomFont.Light.returnFont(isPrice == true ? 14.0 : 16.0)
        ])
        self.textColor = isPrice == true ? UIColor.hexStringToUIColor(hex: "#828282") :colors.ThemeGray.value
        self.font =  CustomFont.Medium.returnFont(isPrice == true ? 14.0 : 16.0)
//            self.titleColor = UIColor.clear
            //UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        self.textColor = isPrice == true ? UIColor.hexStringToUIColor(hex: "#828282") :colors.ThemeGray.value
        
        

    }

    func setRightViewDropDown(image : UIImage)
    {
        let arrow = UIImageView(image:image)
        if let size = arrow.image?.size {
            arrow.frame = CGRect(x: 0, y: 0, width: size.width + 10.0, height: size.height)
        }
        arrow.contentMode = UIView.ContentMode.center
        self.rightView = arrow
        self.rightViewMode = UITextField.ViewMode.always
    }
    
   
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {

        if self.tag == 101{
            if action == #selector(UIResponderStandardEditActions.paste(_:)) ||  action == #selector(UIResponderStandardEditActions.copy(_:)) ||  action == #selector(UIResponderStandardEditActions.selectAll(_:)) ||  action == #selector(UIResponderStandardEditActions.select(_:)) ||  action == #selector(UIResponderStandardEditActions.cut(_:)) ||  action == #selector(UIResponderStandardEditActions.delete(_:))  {
                return false
            }
        }
        return super.canPerformAction(action, withSender: sender)
    }
}

class ThemeSkyTextfield : SkyFloatingLabelTextField {
    
    @IBInspectable var isPrice : Bool = false
    @IBInspectable var image: UIImage? {
        didSet
        {
            setRightViewDropDown(image: image ?? UIImage())
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.font =  CustomFont.Medium.returnFont(15.0)
        self.placeholderFont = CustomFont.Light.returnFont(15.0)
        self.lineColor = UIColor.black.withAlphaComponent(0.3)
        self.lineHeight = 1.0
        self.selectedLineHeight = 1.0
        self.selectedLineColor = UIColor.black.withAlphaComponent(0.3)
        self.selectedTitleColor = UIColor.clear
//            self.titleColor = UIColor.clear
            //UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        self.titleColor = UIColor.clear
        self.placeholderColor = colors.ThemeGray.value
        self.selectedTitleColor = UIColor.clear
        self.textColor = colors.ThemeGray.value
        
    }
    
    
    func setRightViewDropDown(image : UIImage)
    {
        let arrow = UIImageView(image:image)
        if let size = arrow.image?.size {
            arrow.frame = CGRect(x: 0, y: 0, width: size.width + 10.0, height: size.height)
        }
        arrow.contentMode = UIView.ContentMode.center
        self.rightView = arrow
        self.rightViewMode = UITextField.ViewMode.always
    }
}

class ThemeGrayTextfield : UITextField {
    
    @IBInspectable var isSize16 : Bool = false
    @IBInspectable var image: UIImage? {
        didSet
        {
            setRightViewDropDown(image: image ?? UIImage())
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [
            .foregroundColor: UIColor.gray,
            .font: CustomFont.Medium.returnFont(isSize16 == true ? 15.0 : 14.0)
        ])
        self.textColor = colors.ThemeGray.value
        self.font =  CustomFont.Medium.returnFont(isSize16 == true ? 15.0 : 14.0)
//            self.titleColor = UIColor.clear
            //UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        self.textColor = colors.ThemeGray.value
        
    }
    
    
    func setRightViewDropDown(image : UIImage)
    {
        let arrow = UIImageView(image:image)
        if let size = arrow.image?.size {
            arrow.frame = CGRect(x: 0, y: 0, width: size.width + 10.0, height: size.height)
        }
        arrow.contentMode = UIView.ContentMode.center
        self.rightView = arrow
        self.rightViewMode = UITextField.ViewMode.always
    }
}

