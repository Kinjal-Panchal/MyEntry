//
//  CreateTicketReqModel.swift
//  MyEntry
//
//  Created by Kinjal panchal on 31/01/22.
//

import Foundation

//user_id:292
//event_id:16
//ticket_title:Maulik Birthday Party Ticket
//description:Maulik Birthday Party Ticket
//type:VIP
//quantity:1
//price_per_ticket:200
//on_sale_until:2021-10-15 22:10
//maximum_ticket_per_person:1
//add_to_calendar:yes
//seat_allocation:yes
//allowed:yes

class CreateTicketRequestModel : Encodable {
    
    var user_id : String?
    var event_id : String?
    var ticket_title : String?
    var description : String?
    var price : String?
    var type : String?
    var quantity : String?
    var price_per_ticket : String?
    var on_sale_until : String?
    var maximum_ticket_per_person : String?
    var add_to_calendar : String?
    var seat_allocation : String?
    var allowed : String?
    
    enum CodingKeys: String, CodingKey {
        case user_id = "user_id"
        case event_id = "event_id"
        case ticket_title = "ticket_title"
        case description = "description"
        case type = "type"
        case quantity = "quantity"
        case price_per_ticket = "price_per_ticket"
        case on_sale_until = "on_sale_until"
        case maximum_ticket_per_person = "maximum_ticket_per_person"
        case add_to_calendar = "add_to_calendar"
        case seat_allocation = "seat_allocation"
        case allowed = "allowed"
        case price = "price"
    }
}
