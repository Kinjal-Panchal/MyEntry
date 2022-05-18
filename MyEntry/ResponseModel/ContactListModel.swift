//
//  ContactListModel.swift
//  MyEntry
//
//  Created by Kinjal panchal on 25/11/21.
//

import Foundation

class RootContactList : Codable {

        let data : [ContactListData]?
        let message : String?
        let status : Bool?

        enum CodingKeys: String, CodingKey {
                case data = "data"
                case message = "message"
                case status = "status"
        }
    
    required init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                data = try? values.decodeIfPresent([ContactListData].self, forKey: .data)
                message = try? values.decodeIfPresent(String.self, forKey: .message)
                status = try? values.decodeIfPresent(Bool.self, forKey: .status)
        }
}


class ContactListData : Codable {

        let email : String?
        let id : Int?
        let phone : String?
        let username : String?
        var isselected = Bool()

        enum CodingKeys: String, CodingKey {
                case email = "email"
                case id = "id"
                case phone = "phone"
                case username = "username"
        }
    
    required init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                email = try? values.decodeIfPresent(String.self, forKey: .email)
                id = try? values.decodeIfPresent(Int.self, forKey: .id)
                phone = try? values.decodeIfPresent(String.self, forKey: .phone)
                username = try? values.decodeIfPresent(String.self, forKey: .username)
              isselected = false
        }

}
