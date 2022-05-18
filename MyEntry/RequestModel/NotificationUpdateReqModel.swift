//
//  NotificationUpdateReqModel.swift
//  MyEntry
//
//  Created by Kinjal panchal on 22/01/22.
//

import Foundation

class NotificationRequestModel : Encodable {
    
    var user_id : String?
    var notification : String?
    var status : String?
    
    enum CodingKeys: String, CodingKey {
        case user_id = "user_id"
        case notification = "notification"
        case status = "status"
    }
}
