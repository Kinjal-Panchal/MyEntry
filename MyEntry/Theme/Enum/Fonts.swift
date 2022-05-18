import Foundation
import UIKit
enum CustomFont{
    case Regular,SemiBold,Medium,Bold,Light
    func returnFont(_ font:CGFloat)->UIFont{
        switch self {
        case.Light:
            return UIFont(name: "Montserrat-Light", size: font)!
        case .Regular:
            return UIFont(name: "Montserrat-Regular", size: font)!
        case .Medium:
            return UIFont(name: "Montserrat-Medium", size: font)!
        case .SemiBold:
            return UIFont(name: "Montserrat-SemiBold", size: font)!
        case .Bold:
            return UIFont(name: "Montserrat-Bold", size: font)!
        }
        
    }
}

enum FontSize : CGFloat
{
    case size10 = 10.0
    case size8 = 8.0
    case size12 = 12.0
    case size14 = 14.0
    case size16 = 16.0
    case size18 = 18.0
    case size28 = 28.0
    case size20 = 20.0
    case size15 = 15.0
    case size22 = 22.0
    case size13 = 13.0
}


