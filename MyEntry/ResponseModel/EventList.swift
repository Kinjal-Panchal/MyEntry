//
//  EventList.swift
//  MyEntry
//
//  Created by Kinjal panchal on 23/12/21.
//

import Foundation


//// MARK: - DataClass
//class EventList: Codable {
//    let userEvent, upcomingEvent, draftEvent: [Event]?
//
//    enum CodingKeys: String, CodingKey {
//        case userEvent = "user_event"
//        case upcomingEvent = "upcoming_event"
//        case draftEvent = "draft_event"
//    }
//
//    init(userEvent: [Event]?, upcomingEvent: [Event]?, draftEvent: [Event]?) {
//        self.userEvent = userEvent
//        self.upcomingEvent = upcomingEvent
//        self.draftEvent = draftEvent
//    }
//}

// MARK: - Event
class Event: Codable {
    let id: Int?
    let userID, categoryID, templateID, eventTitle: String?
    let eventDescription, eventDate: String?
    let eventTime: String?
    let startTime, endTime, city, country: String?
    let allDayEvent: AllDayEvent?
    let venueLink: String?
    let address: String?
    let isPublicEvent: AllDayEvent?
    let totalAllowed: String?
    let showGuestList: AllDayEvent?
    let sendReminder: String?
    let allowedChildren: AllDayEvent?
    let createdAt, updatedAt: String?
    let templateImage: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case categoryID = "category_id"
        case templateID = "template_id"
        case eventTitle = "event_title"
        case eventDescription = "description"
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
    }

    init(id: Int?, userID: String?, categoryID: String?, templateID: String?, eventTitle: String?, eventDescription: String?, eventDate: String?, eventTime: String?, startTime: String?, endTime: String?, city: String?, country: String?, allDayEvent: AllDayEvent?, venueLink: String?, address: String?, isPublicEvent: AllDayEvent?, totalAllowed: String?, showGuestList: AllDayEvent?, sendReminder: String?, allowedChildren: AllDayEvent?, createdAt: String?, updatedAt: String?, templateImage: String?) {
        self.id = id
        self.userID = userID
        self.categoryID = categoryID
        self.templateID = templateID
        self.eventTitle = eventTitle
        self.eventDescription = eventDescription
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
        self.templateImage = templateImage
    }
}

enum AllDayEvent: String, Codable {
    case no = "no"
    case yes = "yes"
}


