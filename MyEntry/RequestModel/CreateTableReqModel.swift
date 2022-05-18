//
//  CreateTableReqModel.swift
//  MyEntry
//
//  Created by Vipul Dungranee on 23/02/22.
//

import Foundation

enum TableType: Int {
    case circle = 1
    case square
    case rectangle
}

enum SitType: Int {
    case normal = 1
    case vip
}


class CreateTableReqModel : Encodable {
    
    var table_id:Int?
    var tableType : Int? // 1. circle , 2. square , 3. rectangle
    var notes: String?
    var totalSit : Int? // 6
    var  Sits : [SitsDataModel]?

    enum CodingKeys: String, CodingKey {
        case table_id = "id"
        case tableType = "type"
        case notes = "notes"
        case totalSit = "total_sit"
        case Sits = "Sits"
    }

}

class SitsDataModel : Encodable {
    var sit_Id: Int?
    var isFilled: Bool?
    var guestID: Int?
    var sitType: Int? // 1. Normal 2. VIP

    enum CodingKeys: String, CodingKey {
        case sit_Id = "id"
        case isFilled = "isFilled"
        case guestID = "guest_id"
    }
}


class CreateTableReqstModel : Encodable {
    
    var user_id : String?
    var event_id : String?
    var table_name : String?
    var total_seats : String?
    var notes : String?
    var type : String?
    var participant_data : String?
    
    
    enum codingKeys : String , CodingKey {
        case user_id = "user_id"
        case event_id = "event_id"
        case table_name = "table_name"
        case total_seats = "total_seats"
        case notes = "notes"
        case type = "type"
        case participant_data = "participant_data"
    }
}
