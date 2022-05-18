//
//  InitModel.swift
//  MyEntry
//
//  Created by Kinjal panchal on 18/12/21.
//

import Foundation

// MARK: - RootInit
class RootInit: Codable {
    let status: Bool?
    let data: [String]?
    let userData: UserData?

    enum CodingKeys: String, CodingKey {
        case status, data
        case userData = "user_data"
    }

    init(status: Bool?, data: [String]?, userData: UserData?) {
        self.status = status
        self.data = data
        self.userData = userData
    }
}

// MARK: - UserData
class UserData: Codable {
    let id: Int?
    let username, phone, phoneCode, email: String?
    let active: String?
    let image: String?
    let type, xAPIKey: String?
    let isSubscriptionPurchase: Bool?
    let planName, purchasedDate, validTo, price: String?

    enum CodingKeys: String, CodingKey {
        case id, username, phone
        case phoneCode = "phone_code"
        case email, active, image, type
        case xAPIKey = "x-api-key"
        case isSubscriptionPurchase = "is_subscription_purchase"
        case planName = "plan_name"
        case purchasedDate = "purchased_date"
        case validTo = "valid_to"
        case price
    }

    init(id: Int?, username: String?, phone: String?, phoneCode: String?, email: String?, active: String?, image: String?, type: String?, xAPIKey: String?, isSubscriptionPurchase: Bool?, planName: String?, purchasedDate: String?, validTo: String?, price: String?) {
        self.id = id
        self.username = username
        self.phone = phone
        self.phoneCode = phoneCode
        self.email = email
        self.active = active
        self.image = image
        self.type = type
        self.xAPIKey = xAPIKey
        self.isSubscriptionPurchase = isSubscriptionPurchase
        self.planName = planName
        self.purchasedDate = purchasedDate
        self.validTo = validTo
        self.price = price
    }
}
