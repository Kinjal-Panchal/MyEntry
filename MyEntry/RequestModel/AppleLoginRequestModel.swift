//
//  AppleLoginRequestModel.swift
//  MyEntry
//
//  Created by Kinjal panchal on 17/04/22.
//

import Foundation

class AppleLoginRequestModel : Encodable {
    var appleid : String?
    var email : String?
    var username : String?
    
    enum CodingKeys: String, CodingKey {
        case appleid = "apple_id"
        case email = "email"
        case username = "username"
        
    }
}

