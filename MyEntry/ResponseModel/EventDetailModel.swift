//
//  EventDetailModel.swift
//  MyEntry
//
//  Created by Kinjal panchal on 29/01/22.
//

import Foundation

//// MARK: - RootEventDetail
//class RootEventDetail: Codable {
//    let status: Bool?
//    let message: String?
//    let data: EventData?
//
//    init(status: Bool?, message: String?, data: EventData?) {
//        self.status = status
//        self.message = message
//        self.data = data
//    }
//}

// MARK: - RootEventDetail
class RootEventDetail: Codable {
    let status: Bool?
    let message: String?
    let data: EventdetailData?
    let tableData: TableDetail?

    init(status: Bool?, message: String?, data: EventdetailData?, tableData: TableDetail?) {
            self.status = status
            self.message = message
            self.data = data
            self.tableData = tableData
    }
}


// MARK: - DataClass
class EventdetailData: Codable {
    let id: Int
    let userID, categoryID, templateID, eventTitle: String
    let dataDescription, eventDate: String
    let eventTime: String?
    let startTime, endTime, city, country: String
    let allDayEvent, venueLink, address, isPublicEvent: String
    let totalAllowed, showGuestList, sendReminder, allowedChildren: String
    let createdAt, updatedAt, hostName: String
    let totalGuest: Int
    let eventIcon: String
    let templateImage: String
    let ticketData: [TicketData]

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case categoryID = "category_id"
        case templateID = "template_id"
        case eventTitle = "event_title"
        case dataDescription = "description"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case startTime = "start_time"
        case endTime = "end_time"
        case city, country
        case allDayEvent = "all_day_event"
        case venueLink = "venue_link"
        case address
        case isPublicEvent = "is_public_event"
        case totalAllowed = "total_allowed"
        case showGuestList = "show_guest_list"
        case sendReminder = "send_reminder"
        case allowedChildren = "allowed_children"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case hostName = "host_name"
        case totalGuest = "total_guest"
        case eventIcon = "event_icon"
        case templateImage = "template_image"
        case ticketData = "ticket_data"
    }
    init(id: Int, userID: String, categoryID: String, templateID: String, eventTitle: String, dataDescription: String, eventDate: String, eventTime: String?, startTime: String, endTime: String, city: String, country: String, allDayEvent: String, venueLink: String, address: String, isPublicEvent: String, totalAllowed: String, showGuestList: String, sendReminder: String, allowedChildren: String, createdAt: String, updatedAt: String, hostName: String, totalGuest: Int, eventIcon: String, templateImage: String, ticketData: [TicketData]) {
        self.id = id
        self.userID = userID
        self.categoryID = categoryID
        self.templateID = templateID
        self.eventTitle = eventTitle
        self.dataDescription = dataDescription
        self.eventDate = eventDate
        self.eventTime = eventTime
        self.startTime = startTime
        self.endTime = endTime
        self.city = city
        self.country = country
        self.allDayEvent = allDayEvent
        self.venueLink = venueLink
        self.address = address
        self.isPublicEvent = isPublicEvent
        self.totalAllowed = totalAllowed
        self.showGuestList = showGuestList
        self.sendReminder = sendReminder
        self.allowedChildren = allowedChildren
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.hostName = hostName
        self.totalGuest = totalGuest
        self.eventIcon = eventIcon
        self.templateImage = templateImage
        self.ticketData = ticketData
    }
}

// MARK: - TicketDatum
class TicketData: Codable {
    let id: Int
    let userID, eventID, ticketTitle, ticketDatumDescription: String
    let type, price, quantity, pricePerTicket: String
    let onSaleUntil, maximumTicketPerPerson, addToCalendar, seatAllocation: String
    let allowed, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case eventID = "event_id"
        case ticketTitle = "ticket_title"
        case ticketDatumDescription = "description"
        case type, price, quantity
        case pricePerTicket = "price_per_ticket"
        case onSaleUntil = "on_sale_until"
        case maximumTicketPerPerson = "maximum_ticket_per_person"
        case addToCalendar = "add_to_calendar"
        case seatAllocation = "seat_allocation"
        case allowed
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    init(id: Int, userID: String, eventID: String, ticketTitle: String, ticketDatumDescription: String, type: String, price: String, quantity: String, pricePerTicket: String, onSaleUntil: String, maximumTicketPerPerson: String, addToCalendar: String, seatAllocation: String, allowed: String, createdAt: String, updatedAt: String) {
        self.id = id
        self.userID = userID
        self.eventID = eventID
        self.ticketTitle = ticketTitle
        self.ticketDatumDescription = ticketDatumDescription
        self.type = type
        self.price = price
        self.quantity = quantity
        self.pricePerTicket = pricePerTicket
        self.onSaleUntil = onSaleUntil
        self.maximumTicketPerPerson = maximumTicketPerPerson
        self.addToCalendar = addToCalendar
        self.seatAllocation = seatAllocation
        self.allowed = allowed
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
// MARK: - TableData
class TableDetail: Codable {
    let totalTable, totalSeats, totalVacant, totalWaitlist: Int?

    enum CodingKeys: String, CodingKey {
        case totalTable = "total_table"
        case totalSeats = "total_seats"
        case totalVacant = "total_vacant"
        case totalWaitlist = "total_waitlist"
    }
    init(totalTable: Int?, totalSeats: Int?, totalVacant: Int?, totalWaitlist: Int?) {
        self.totalTable = totalTable
        self.totalSeats = totalSeats
        self.totalVacant = totalVacant
        self.totalWaitlist = totalWaitlist
    }
}
