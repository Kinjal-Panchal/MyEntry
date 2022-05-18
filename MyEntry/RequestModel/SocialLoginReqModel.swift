//
//  SocialLoginReqModel.swift
//  MyEntry
//
//  Created by Kinjal panchal on 25/01/22.
//

import Foundation

class SocialLoginRequestModel : Encodable {
    
    var identity : String?
    var login_type : String?
    var username : String?
    
    enum CodingKeys: String, CodingKey {
        case identity = "identity"
        case login_type = "login_type"
        case username = "username"
        
    }
}

