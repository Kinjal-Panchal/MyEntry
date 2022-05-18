//
//  WebServicesSubclass.swift
//  Danfo_Rider
//
//  Created by kinjal panchal on 04/06/21.
//

import Foundation
import UIKit

class WebServiceSubClass{

    class func RegisterApi(reqModel : RegisterRequestModel , completion: @escaping (Bool,String,RootRegister?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.registerEmail.rawValue, requestModel: reqModel, responseModel: RootRegister.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    class func RegisterWithPhoneApi(reqModel : RegisterPhoneRequestModel , completion: @escaping (Bool,String,RootRegister?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.registerPhone.rawValue, requestModel: reqModel, responseModel: RootRegister.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func SendOTP(reqModel: OTPReqModel , completion : @escaping (Bool,String,RootCommonModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.sendOTP.rawValue, requestModel: reqModel, responseModel: RootCommonModel.self) { status, message, response, error in
            completion(status, message, response, error)
        }
    }
    
    class func login(reqModel : LoginReqModel , completion : @escaping (Bool,String,RootRegister?,Any) -> ()) {
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.login.rawValue, requestModel: reqModel, responseModel: RootRegister.self) { status, message, response, error in
            completion(status, message, response, error)
       }
   }
    class func categoriesList(reqmodel : [String:AnyObject] , completion : @escaping (Bool,String,RootCategories?,Any) -> ()) {
        
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.categoriesList.rawValue, responseModel: RootCategories.self) { status, message, response, error in
            completion(status, message, response, error)
       }
    }
    
    
    class func templatelist(templatlistReqmodel : TemplatListReqModel , completion : @escaping (Bool,String,RootTemplateList?,Any) -> ()) {
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.templateList.rawValue, requestModel: templatlistReqmodel, responseModel: RootTemplateList.self) { status, message, response, error in
            completion(status, message, response, error)
       }
    }
    class func syncContactData(ContactReqModel:ConatactListReqModel , completion : @escaping (Bool,String,RootCommonResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.addContactList.rawValue, requestModel: ContactReqModel, responseModel: RootCommonResponseModel.self) { status, message, response, error in
            completion(status, message, response, error)
       }
    }
    class func getContactList(ContactListReqModel : EventListReqModel , completion : @escaping (Bool,String,RootContactList?,Any) -> ()) {
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.syncUserList.rawValue, requestModel: ContactListReqModel, responseModel: RootContactList.self) { status, message, response, error in
            completion(status, message, response, error)
       }
    }
    
    class func uploadTemplate(TemplateImg: UIImage,TemplateReqModel:TemplateReqModel , complition:@escaping (Bool,String,RootCommonResponseModel?,Any)->()){
        URLSessionRequestManager.makeImageUploadRequest(urlString: ApiKey.addTemplate.rawValue, requestModel: TemplateReqModel, responseModel: RootCommonResponseModel.self, image:TemplateImg , imageKey: "image") { status, message, response, error in
            
            complition(status, message, response, error)
        }
       }
    
    class func appUsersList(reqmodel : [String:AnyObject] , completion : @escaping (Bool,String,RootContactList?,Any) -> ()) {
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.appUsers.rawValue, responseModel: RootContactList.self) { status, message, response, error in
            completion(status, message, response, error)
       }
    }
    
    class func createEvent(CreateEventReqModel : CreateEventReqModel , completion : @escaping (Bool,String,RootCreateEvent?,Any) -> ()) {
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.createEvent.rawValue, requestModel: CreateEventReqModel, responseModel: RootCreateEvent.self) { status, message, response, error in
            completion(status, message, response, error)
       }
    }
    class func EditEvent(EditEventReqModel :  CreateEventReqModel, completion : @escaping (Bool,String,RootCreateEvent?,Any) -> ()) {
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.createEvent.rawValue, requestModel: EditEventReqModel, responseModel: RootCreateEvent.self) { status, message, response, error in
            completion(status, message, response, error)
       }
    }
    
    class func UpdateProfile(UpdateProfileModel : UpdateProfileReqModel,image:UIImage, complition:@escaping (Bool,String,RootRegister?,Any) -> ()) {
        
        URLSessionRequestManager.makeImageUploadRequest(urlString: ApiKey.updateProfile.rawValue, requestModel: UpdateProfileModel, responseModel: RootRegister.self, image: image, imageKey: "image", completion: complition)
       }
    
    class func changePassword(changePassReqModel : ChangePasswordReqModel , completion : @escaping (Bool,String,RootCommonResponseModel?,Any) -> ()) {
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.changePassword.rawValue, requestModel: changePassReqModel, responseModel: RootCommonResponseModel.self) { status, message, response, error in
            completion(status, message, response, error)
       }
    }
    class func subScriptionPlanList(reqmodel : [String:AnyObject] , completion : @escaping (Bool,String,RootSubscriptionPlanList?,Any) -> ()) {
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.subScriptionPlanList.rawValue, responseModel: RootSubscriptionPlanList.self) { status, message, response, error in
            completion(status, message, response, error)
       }
    }
    class func webserviceInit(userId : String , reqmodel : [String:AnyObject] , completion : @escaping (Bool,String,RootInit?,Any) -> ()) {
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.Init.rawValue + "\(kAPPVesion)/\(userId)", responseModel: RootInit.self) { status, message, response, error in
            completion(status, message, response, error)
       }
    }
    class func removeProfilePic(RemoveProfileReqModel : removeProfileReqModel , completion : @escaping (Bool,String,RootRegister?,Any) -> ()) {
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.removeProfile.rawValue, requestModel: RemoveProfileReqModel, responseModel: RootRegister.self) { status, message, response, error in
            completion(status, message, response, error)
       }
    }
    class func EventListType(eventReqModel : EventListReqModel , complition : @escaping (Bool,String,RootEventList?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.eventList.rawValue, requestModel: eventReqModel, responseModel: RootEventList.self) { status, message, response, error in
            complition(status,message,response,error)
        }
    }
    class func UpcomingEventList(eventReqModel : EventListReqModel, complition : @escaping (Bool,String,RootUpcomingEvent?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.eventList.rawValue, requestModel: eventReqModel, responseModel: RootUpcomingEvent.self) { status, message, response, error in
            complition(status,message,response,error)
        }
    }
    class func removeEvent(reqModel:EventRemoveReqModel ,  complition : @escaping (Bool,String,RootCommonResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.deleteEvent.rawValue, requestModel: reqModel, responseModel: RootCommonResponseModel.self) { status, message, response, error in
            complition(status,message,response,error)
        }
    }
    class func notificationList(reqModel : CommonReqModel , complition : @escaping (Bool,String,RootNotificationList?,Any) -> ()){
        
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.notificationList.rawValue, requestModel: reqModel, responseModel: RootNotificationList.self) { status, message, response, error in
            complition(status,message,response,error)
        }
    }
    class func notificationStatusUpdate(reqModel : NotificationRequestModel , complition : @escaping (Bool,String,RootCommonResponseModel?,Any) -> ()){
        
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.notificationstatus.rawValue, requestModel: reqModel, responseModel: RootCommonResponseModel.self) { status, message, response, error in
            complition(status,message,response,error)
        }
    }
    
    class func SocialLogin(reqModel : SocialLoginRequestModel , completion: @escaping (Bool,String,RootRegister?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.socialLogin.rawValue, requestModel: reqModel, responseModel: RootRegister.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func appleLogin(reqModel : AppleLoginRequestModel , completion: @escaping (Bool,String,RootRegister?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.appleLogin.rawValue, requestModel: reqModel, responseModel: RootRegister.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    

    class func eventDetail(reqModel : EventDetailReqModel , completion : @escaping (Bool,String,RootEventDetail?,Any) -> ()) {
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.eventDetail.rawValue, requestModel: reqModel, responseModel: RootEventDetail.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func createTicket(reqModel : CreateTicketRequestModel , completion : @escaping (Bool,String,RootCommonResponseModel?,Any) -> ()) {
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.createTicket.rawValue, requestModel: reqModel, responseModel: RootCommonResponseModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func ParticipateList(reqModel : EventDetailReqModel, completion : @escaping (Bool,String,RootParticipent?,Any) -> ()) {
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.eventParicipentList.rawValue, requestModel: reqModel, responseModel: RootParticipent.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func CreateTable(reqModel : CreateEventReqModel , completion : @escaping (Bool,String,RootCommonResponseModel?,Any) -> ()) {
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.createTable.rawValue, requestModel: reqModel, responseModel: RootCommonResponseModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func AttendEvent(reqModel : AttendEventReqstModel , completion : @escaping (Bool,String,RootCommonResponseModel?,Any) -> ()) {
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.attendEvent.rawValue, requestModel: reqModel, responseModel: RootCommonResponseModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
}
