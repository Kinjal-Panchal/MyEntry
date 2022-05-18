//
//  AuthRequestModel.swift
//  MyEntry
//
//  Created by Kinjal panchal on 06/11/21.
//

import Foundation

//MARK:- Register Request Model
class RegisterRequestModel: Encodable{
    
    var username : String?
    var email : String?
    var password : String?
    
    enum CodingKeys: String, CodingKey {
        case username = "username"
        case email = "email"
        case password = "password"
    }
}

//MARK:- Register Request Model
class RegisterPhoneRequestModel: Encodable{
    
    var username : String?
    var phone_code : String?
    var mobile_number:String?
    var password : String?
    
    enum CodingKeys: String, CodingKey {
        case username = "username"
        case phone_code = "phone_code"
        case mobile_number = "mobile_number"
        case password = "password"
    }
}


//MARK:- ====== OTP Model ====
class OTPReqModel : Encodable {
    
    var type : String?
    var identity : String?
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case identity = "identity"
    }
}


//MARK:- ===== Login Model ====
class LoginReqModel : Encodable {
    
    var identity:String?
    var password:String?
    
    enum CodingKeys: String, CodingKey {
        
        case password = "password"
        case identity = "identity"
    }

}

//MARK:- === Change Password Model
class ChangePasswordReqModel : Encodable {
    
    var user_id : String?
    var current_password : String?
    var new_password : String?
    var new_confirm_password : String?
    
    enum CodingKeys: String, CodingKey {
        
        case user_id = "user_id"
        case current_password = "current_password"
        case new_password = "new_password"
        case new_confirm_password = "new_confirm_password"
    }
}

//MARK:- === Remove Profile Model
class removeProfileReqModel : Encodable {
    var user_id : String?
    
    enum CodingKeys: String, CodingKey {
        case user_id = "user_id"
    }
}
