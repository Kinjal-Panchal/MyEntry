//
//  apiPaths.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 04/06/21.
//

import Foundation

typealias NetworkRouterCompletion = ((Data?,[String:Any]?, Bool) -> ())

enum APIEnvironment : String {
 
//Development URL :
    case AssetsUrl = "http://65.1.154.172/"
    case Development = "http://www.myentry.ae/api/"
    case Profilebu = "http://65.1.154.172/api/"
    case Live = "not provided"
    case GoogleMapKey = "AIzaSyD9aZBxr4MjVuneyUp4x969up5GUvTY6vk"
    
    
    static var baseURL: String{
        return APIEnvironment.environment.rawValue
    }
    
    static var environment: APIEnvironment{
        return .Development
    }
    
    static var headers : [String:String]{
        if userDefaults.object(forKey: UserDefaultsKey.isUserLogin.rawValue) != nil {
            
            if userDefaults.object(forKey: UserDefaultsKey.isUserLogin.rawValue) as? Bool == true {
                
                if userDefaults.object(forKey:  UserDefaultsKey.userProfile.rawValue) != nil {
                    do {
                        if UserDefaults.standard.value(forKey: UserDefaultsKey.X_API_KEY.rawValue) != nil, UserDefaults.standard.value(forKey:  UserDefaultsKey.isUserLogin.rawValue) as? Bool ?? Bool(){
                            return [UrlConstant.HeaderKey : UrlConstant.AppHostKey, UrlConstant.XApiKey : Singleton.sharedInstance.UserProfilData?.xApiKey ?? ""]
                        }else{
                            return [UrlConstant.XApiKey : Singleton.sharedInstance.UserProfilData?.xApiKey ?? ""]
                        }
                    }
                }
            }
        }
        return [UrlConstant.HeaderKey : UrlConstant.AppHostKey]
    }
}

enum ApiKey: String {
    
    case Init           = "auth/init/ios/"
    case registerPhone  = "auth/register_with_phone"
    case registerEmail  = "auth/register_with_email"
    case login          = "auth/login"
    case sendOTP        = "auth/send_otp"
    case categoriesList = "events/category_list"
    case eventList      = "events/all_event_list"
    case templateList   = "events/template_list"
    case addContactList  = "events/add_contact_sync_data"
    case syncUserList    = "events/contact_users_list"
    case addTemplate     = "events/add_template"
    case appUsers        = "events/app_users"
    case createEvent     = "events/create_event"
    case updateProfile   = "events/edit_profile"
    case changePassword  = "events/change_password"
    case subScriptionPlanList = "events/get_subscription_plans_list"
    case removeProfile   =  "events/remove_profile_pic"
    case deleteEvent     = "events/delete_event"
    case EditEvent       = "events/edit_event"
    case notificationList = "events/notification_setting_list"
    case notificationstatus = "events/notification_on_off"
    case socialLogin        = "auth/social_login"
    case eventDetail    = "events/event_detail"
    case createTicket   = "events/create_ticket"
    case eventParicipentList = "events/event_participant_list"
    case createTable  = "events/add_table"
    case attendEvent = "events/is_attend_event"
    case appleLogin  = "auth/apple_login"
    
}

 

