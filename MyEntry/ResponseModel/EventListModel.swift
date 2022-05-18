//
//  EventListModel.swift
//  MyEntry
//
//  Created by Kinjal panchal on 20/11/21.
//

import Foundation

// MARK: - RootEventList
class RootEventList: Codable {
    let status: Bool?
    let message: String?
    let data: [EventData]?

    init(status: Bool?, message: String?, data: [EventData]?) {
        self.status = status
        self.message = message
        self.data = data
    }
}

// MARK: - RootUpcomingEvent
class RootUpcomingEvent: Codable {
    let status: Bool?
    let message: String?
    let data: [RootUpcomingEventData]?

    init(status: Bool?, message: String?, data: [RootUpcomingEventData]?) {
        self.status = status
        self.message = message
        self.data = data
    }
}

//MARK: === Upcoming Event ===
class RootUpcomingEventData: Codable {
    let date: String?
    let data: [EventData]?

    init(date: String?, data: [EventData]?) {
        self.date = date
        self.data = data
    }
}

// MARK: - RootEventList
class RootCreateEvent: Codable {
    let status: Bool?
    let message: String?
    let data: EventData?

    init(status: Bool?, message: String?, data: EventData?) {
        self.status = status
        self.message = message
        self.data = data
    }
}
// MARK: - Datum
class EventData: Codable {
    let id: Int?
    let userID, categoryID, templateID, eventTitle: String?
    let datumDescription, eventDate: String?
    let eventTime: String?
    let startTime, endTime, city, country: String?
    let allDayEvent, venueLink, address, isPublicEvent: String?
    let totalAllowed, showGuestList, sendReminder, allowedChildren: String?
    let createdAt, updatedAt: String?
    let templateImage: String?
    let hostName: String?
    let totalGuest: Int?
    let eventIcon: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case categoryID = "category_id"
        case templateID = "template_id"
        case eventTitle = "event_title"
        case datumDescription = "description"
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
        case templateImage = "template_image"
        case hostName = "host_name"
        case totalGuest = "total_guest"
        case eventIcon = "event_icon"
    }
}
