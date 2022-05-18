//
//  CalanderHelper.swift
//  MyEntry
//
//  Created by Kinjal panchal on 19/03/22.
//

import Foundation
import EventKit
class EventHelper
{
    let appleEventStore = EKEventStore()
    var StartDate = NSDate()
    var endDate = NSDate()
    var isfullDay = false
    var calendars: [EKCalendar]?
    static let shared = EventHelper()
    
    
    func generateEvent(Title:String,Notes:String) {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)

        switch (status)
        {
        case EKAuthorizationStatus.notDetermined:
            // This happens on first-run
            requestAccessToCalendar(Title: Title, Notes: Notes)
        case EKAuthorizationStatus.authorized:
            // User has access
            print("User has access to calendar")
            self.addAppleEvents(Title: Title, Notes: Notes)
        case EKAuthorizationStatus.restricted, EKAuthorizationStatus.denied:
            // We need to help them give us permission
            noPermission()
        }
    }
    func noPermission()
    {
        UtilityClass.OkalerwithAction(Msg: "User has to change settings...goto settings to view access") {
            
        }
        print("User has to change settings...goto settings to view access")
    }
    func requestAccessToCalendar(Title: String, Notes: String) {
        appleEventStore.requestAccess(to: .event, completion: { (granted, error) in
            if (granted) && (error == nil) {
                DispatchQueue.main.async {
                    print("User has access to calendar")
                    self.addAppleEvents(Title: Title, Notes: Notes)
                }
            } else {
                DispatchQueue.main.async{
                    self.noPermission()
                }
            }
        })
    }
    
    //MARK: ======= Add Event ======
    func addAppleEvents(Title:String,Notes:String)
    {
        let event:EKEvent = EKEvent(eventStore: appleEventStore)
        event.title = Title
        event.startDate = StartDate as Date
        event.endDate = endDate as Date
        event.notes = Notes
        event.calendar = appleEventStore.defaultCalendarForNewEvents

        do {
            try appleEventStore.save(event, span: .thisEvent)
            print("events added with dates:")
        } catch let e as NSError {
            print(e.description)
            return
        }
        print("Saved Event")
    }
}
