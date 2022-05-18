//
//  CustomImageView.swift
//  SecondNile
//
//  Created by panchal kinjal on 18/07/21.
//

import Foundation
import UIKit

class ThemeRoundImage : UIImageView {
    @IBInspectable var isRound : Bool = false


    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = isRound == true ? 10 : self.frame.height / 2
        self.clipsToBounds = true
    }
}

    extension UIImage {
        func createSelectionIndicator(color: UIColor, size: CGSize, lineHeight: CGFloat) -> UIImage {
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
            color.setFill()
            UIRectFill(CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: size.width, height: lineHeight)))
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image!
        }
    }
//size.height - lineHeight

