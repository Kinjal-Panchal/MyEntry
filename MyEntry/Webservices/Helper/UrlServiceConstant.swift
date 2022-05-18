//
//  UrlServiceConstant.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 04/06/21.
//

import Foundation

class UrlConstant{
    //MARK:- WebService Header Key
    static let HeaderKey = "Api-Key"
    static let XApiKey = "x-api-key"
    static let AppHostKey = "3504d8b2-5616-409d-a64f-1957302d82b0-b436fe1e-b9a8-4edf-b554-6f23f56d958f"
    static let ResponseMessage = "message"
    static let SessionExpired = "UrlConstant_SessionExpired"
    static let SomethingWentWrong = "UrlConstant_SomethingWentWrong"
    static let NoInternetConnection =  "UrlConstant_NoInternetConnection"
    static let RequestTimeOut = "UrlConstant_RequestTimeOut"
    static let Status = "status"
   
}

let SessionExpiredResponseDic = [UrlConstant.ResponseMessage: UrlConstant.SessionExpired]
let SomethingWentWrongResponseDic = [UrlConstant.ResponseMessage: UrlConstant.SomethingWentWrong]
let NoInternetResponseDic = [UrlConstant.ResponseMessage: UrlConstant.NoInternetConnection]



