//
//  AttendEventRequestModel.swift
//  MyEntry
//
//  Created by Kinjal panchal on 19/03/22.
//

import Foundation

class AttendEventReqstModel : Encodable {
    
    var user_id : String?
    var event_id : String?
    var status : String?
    
    enum codingKeys : String , CodingKey {
        case user_id = "user_id"
        case event_id = "event_id"
        case status = "status"
    }
}
