//
//  SubScriptionListModel.swift
//  MyEntry
//
//  Created by Kinjal panchal on 11/12/21.
//

import Foundation

// MARK: - RootSubscriptionPlanList
class RootSubscriptionPlanList: Codable {
    let status: Bool?
    let message: String?
    let data: [PlanData]?
    let features: [String]?

    init(status: Bool?, message: String?, data: [PlanData]?, features: [String]?) {
        self.status = status
        self.message = message
        self.data = data
        self.features = features
    }
}

// MARK: - Datum
class PlanData: Codable {
    let subscriptionID: Int?
    let planName, price: String?
    var selected : Bool?
    let items: [String]?

    enum CodingKeys: String, CodingKey {
        case subscriptionID = "subscription_id"
        case planName = "plan_name"
        case price, items
    }

    init(subscriptionID: Int?, planName: String?, price: String?, items: [String]?,selected:Bool?) {
        self.subscriptionID = subscriptionID
        self.planName = planName
        self.price = price
        self.items = items
        self.selected = false
    }
}
