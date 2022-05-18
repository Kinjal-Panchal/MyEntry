//
//  ContactReqModel.swift
//  MyEntry
//
//  Created by Kinjal panchal on 24/11/21.
//

import Foundation
import UIKit

//MARK:- ===== Event Model ====
class ConatactListReqModel : Encodable {
    
    var user_id:String?
    var contacts:String?
    
    enum CodingKeys: String, CodingKey {
        
        case user_id = "user_id"
        case contacts = "contacts"
    }

}

class CommonReqModel : Encodable {
    var user_id:String?
    
    enum CodingKeys: String, CodingKey {
        case user_id = "user_id"
    }
}
