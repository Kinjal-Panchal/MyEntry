//
//  UpdateProfileReqModel.swift
//  MyEntry
//
//  Created by Kinjal panchal on 04/12/21.
//

import Foundation


//MARK:- ====== update Profile Model ====
class UpdateProfileReqModel : Encodable {
    
    var username : String?
    var email : String?
    var phone : String?
    var userId : String?
    var phone_code : String?
    var type : String?
    var birthdate : String?
    
    enum CodingKeys: String, CodingKey {
        case username = "username"
        case email = "email"
        case phone = "phone"
        case userId = "user_id"
        case phone_code = "phone_code"
        case type = "type"
        case birthdate = "birth_date"
    }
}
