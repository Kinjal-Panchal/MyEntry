//
//  ParticipantModel.swift
//  MyEntry
//
//  Created by Kinjal panchal on 27/02/22.
//

import Foundation

// MARK: - RootParticipent
class RootParticipent: Codable {
    let status: Bool?
    let message: String?
    let data: [ParticipentData]?

    init(status: Bool?, message: String?, data: [ParticipentData]?) {
        self.status = status
        self.message = message
        self.data = data
    }
}

// MARK: - Datum
class ParticipentData: Codable {
    let userID: Int?
    let username, phone, phoneCode: String?
    let email: String?
    let status: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case username, phone
        case phoneCode = "phone_code"
        case email, status
    }

    init(userID: Int?, username: String?, phone: String?, phoneCode: String?, email: String?, status: String?) {
        self.userID = userID
        self.username = username
        self.phone = phone
        self.phoneCode = phoneCode
        self.email = email
        self.status = status
    }
}
