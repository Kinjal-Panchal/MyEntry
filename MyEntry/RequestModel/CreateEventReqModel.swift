//
//  CreateEventReqModel.swift
//  MyEntry
//
//  Created by Kinjal panchal on 28/11/21.
//

import Foundation

//user_id="15"' \
//--form 'category_id="5"' \
//--form 'event_title="Maulik Birthday Party"' \
//--form 'description="dsdsdsadsadjhdjshjdh"' \
//--form 'event_date="25-06-2022"' \
//--form 'all_day_event="no"' \
//--form 'address="Ahmedabad"' \
//--form 'is_public_event="no"' \
//--form 'total_allowed="20"' \
//--form 'show_guest_list="no"' \
//--form 'send_reminder="3 days"' \
//--form 'allowed_children="yes"' \
//--form 'event_time="07:00 PM - 10:00 PM"' \
//--form 'venue_link="https://twitter.com/search?q=birthday&ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Esearch"' \
//--form 'guest_user_id="15,26"'

//MARK:- ===== Create event Request Model ====
class CreateEventReqModel : Encodable {
    
    var user_id:String?
    var category_id:String?
    var event_title:String?
    var description:String?
    var event_date:String?
    var all_day_event:String?
    var address:String?
    var is_public_event:String?
    var total_allowed:String?
    var show_guest_list:String?
    var send_reminder:String?
    var allowed_children:String?
    var event_time :String?
    var venue_link : String?
    var guest_user_id : String?
    var template_id : String?
    var city : String?
    var country : String?
    var startTime : String?
    var endTime : String?

    
    enum CodingKeys: String, CodingKey {
        
        case user_id = "user_id"
        case category_id = "category_id"
        case event_title = "event_title"
        case description = "description"
        case event_date = "event_date"
        case all_day_event = "all_day_event"
        case address = "address"
        case is_public_event = "is_public_event"
        case total_allowed = "total_allowed"
        case show_guest_list = "show_guest_list"
        case send_reminder = "send_reminder"
        case allowed_children = "allowed_children"
        case event_time = "event_time"
        case venue_link = "venue_link"
        case guest_user_id = "guest_user_id"
        case template_id = "template_id"
        case city = "city"
        case country = "country"
        case startTime = "start_time"
        case endTime = "end_time"

    }

}
