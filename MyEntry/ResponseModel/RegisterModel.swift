//
//  RegisterModel.swift
//  MyEntry
//
//  Created by Kinjal panchal on 06/11/21.
//

import Foundation

class RootRegister : Codable {

        let data : RegisterData?
        let message : String?
        let status : Bool?

        enum CodingKeys: String, CodingKey {
                case data = "data"
                case message = "message"
                case status = "status"
        }
    
     required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        data = try? values?.decodeIfPresent(RegisterData.self, forKey: .data)
        message = try? values?.decodeIfPresent(String.self, forKey: .message)
        status = try? values?.decodeIfPresent(Bool.self, forKey: .status)
    }
}

class RegisterData : Codable {

        let active : String?
        let email : String?
        let id : Int?
        let phone : String?
        let phoneCode : String?
        let username : String?
        let xApiKey : String?
        let image : String?
        let isSubScription : Int?
        let planName  : String?
        let price : String?
        let purchasedDate : String?
        let valid_to : String?
        let birthDate : String?
        let type : String?
    
        enum CodingKeys: String, CodingKey {
                case active = "active"
                case email = "email"
                case id = "id"
                case phone = "phone"
                case phoneCode = "phone_code"
                case username = "username"
                case xApiKey = "x-api-key"
                case image = "image"
                case isSubScription = "is_subscription_purchase"
                case planName  = "plan_name"
                case price = "price"
                case purchasedDate = "purchased_date"
                case valid_to = "valid_to"
                case birthDate = "birth_date"
                case type = "type"
        }
    
    required init(from decoder: Decoder) throws {
                let values = try? decoder.container(keyedBy: CodingKeys.self)
                active = try? values?.decodeIfPresent(String.self, forKey: .active)
                email = try values?.decodeIfPresent(String.self, forKey: .email)
                id = try values?.decodeIfPresent(Int.self, forKey: .id)
                phone = try values?.decodeIfPresent(String.self, forKey: .phone)
                phoneCode = try values?.decodeIfPresent(String.self, forKey: .phoneCode)
                username = try? values?.decodeIfPresent(String.self, forKey: .username)
                xApiKey = try? values?.decodeIfPresent(String.self, forKey: .xApiKey)
                image = try? values?.decodeIfPresent(String.self, forKey: .image)
                isSubScription = try? values?.decodeIfPresent(Int.self, forKey: .isSubScription)
                planName = try? values?.decodeIfPresent(String.self, forKey: .planName)
                price = try? values?.decodeIfPresent(String.self, forKey: .price)
                purchasedDate = try? values?.decodeIfPresent(String.self, forKey: .purchasedDate)
                valid_to = try? values?.decodeIfPresent(String.self, forKey: .valid_to)
                 birthDate = try? values?.decodeIfPresent(String.self, forKey: .birthDate)
                 type = try? values?.decodeIfPresent(String.self, forKey: .type)
               
        }
}


class RootCommonModel : Codable {

        let message : String?
        let status : Bool?
        let otp : String?

        enum CodingKeys: String, CodingKey {
            case message = "message"
            case status = "status"
            case otp = "otp"
        }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        otp = try? values?.decodeIfPresent(String.self, forKey: .otp)
        message = try? values?.decodeIfPresent(String.self, forKey: .message)
        status = try? values?.decodeIfPresent(Bool.self, forKey: .status)
    }

}

class RootCommonResponseModel : Codable {

        let message : String?
        let status : Bool?
         

        enum CodingKeys: String, CodingKey {
            case message = "message"
            case status = "status"
        }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        message = try? values?.decodeIfPresent(String.self, forKey: .message)
        status = try? values?.decodeIfPresent(Bool.self, forKey: .status)
    }

}
