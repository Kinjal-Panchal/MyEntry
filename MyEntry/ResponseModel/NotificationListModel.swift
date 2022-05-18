//
//  NotificationListModel.swift
//  MyEntry
//
//  Created by Kinjal panchal on 22/01/22.
//

import Foundation

// MARK: - RootNotificationList
class RootNotificationList: Codable {
    let status: Bool?
    let data: NotificatioTypeData?
    
    init(status: Bool?, data: NotificatioTypeData?) {
        self.status = status
        self.data = data
    }
}

// MARK: - DataClass
class NotificatioTypeData: Codable {
    let guestRsvp, iReceiveMessage, whenAnInviteUndelivered, whenIReceiveAnInvitation: String?
    let reminderEvent, marketingNotification: String?

    enum CodingKeys: String, CodingKey {
        case guestRsvp = "guest_rsvp"
        case iReceiveMessage = "i_receive_message"
        case whenAnInviteUndelivered = "when_an_invite_undelivered"
        case whenIReceiveAnInvitation = "when_i_receive_an_invitation"
        case reminderEvent = "reminder_event"
        case marketingNotification = "marketing_notification"
    }

    init(guestRsvp: String?, iReceiveMessage: String?, whenAnInviteUndelivered: String?, whenIReceiveAnInvitation: String?, reminderEvent: String?, marketingNotification: String?) {
        self.guestRsvp = guestRsvp
        self.iReceiveMessage = iReceiveMessage
        self.whenAnInviteUndelivered = whenAnInviteUndelivered
        self.whenIReceiveAnInvitation = whenIReceiveAnInvitation
        self.reminderEvent = reminderEvent
        self.marketingNotification = marketingNotification
    }
}

// MARK: - Datum
class NotificationTypes: Codable {
    let key, value, status: String?
    
    init(key: String?, value: String?, status: String?) {
        self.key = key
        self.value = value
        self.status = status
    }
}
