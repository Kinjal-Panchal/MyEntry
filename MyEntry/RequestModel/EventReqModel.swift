//
//  EventReqModel.swift
//  MyEntry
//
//  Created by Kinjal panchal on 20/11/21.
//

import Foundation

//MARK:- ===== Event Model ====
class EventListReqModel : Encodable {
    
    var type:String?
    var user_id:String?
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case user_id = "user_id"

    }
}
class TemplatListReqModel : Encodable {
    
    var user_id:String?
    var category_id : String?
    
    enum CodingKeys: String, CodingKey {
        case user_id = "user_id"
        case category_id = "category_id"

    }
}

class EventRemoveReqModel : Encodable {
    
    var id : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
    }
}

class EventDetailReqModel : Encodable {
    
    var event_id : String?
    
    enum codingKeys : String , CodingKey {
        case event_id = "event_id"
    }
}
