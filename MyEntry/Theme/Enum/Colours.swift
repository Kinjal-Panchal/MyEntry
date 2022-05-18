//
//  Colours.swift
//  Seconf Nile
//
//  Created by panchal kinjal on 16/07/21.
//

import Foundation
import UIKit

enum colors{
    case ThemeYellow,ThemeLightBlue,ThemeRed,ThemeGreen,ThemeGray,ThemePink


    var value:UIColor{
        switch self {
        case .ThemePink :
             return UIColor(hexString:"#FFF2F3")
        case .ThemeYellow:
            return UIColor(hexString:"#FDE088")
        case.ThemeRed:
            return UIColor(hexString:"#E8505B")
        case .ThemeGreen:
            return UIColor(hexString:"#54A758")
        case .ThemeGray :
            return UIColor(hexString:"#4F4F4F")
        case .ThemeLightBlue :
            return UIColor(hexString: "#A1C3FC")
        }
    }
}
