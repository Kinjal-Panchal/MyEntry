//
//  TemplateRequestModel.swift
//  MyEntry
//
//  Created by Kinjal panchal on 27/11/21.
//

import Foundation
import UIKit

//MARK:- ===== Template Model ====
class TemplateReqModel : Encodable {
    
    var user_id:String?
    var name:String?
    var category_id:String?
    //var image:UIImage?
    
    enum CodingKeys: String, CodingKey {
        case user_id = "user_id"
        case name = "name"
        case category_id = "category_id"
        //case image = "image"
    }
}
