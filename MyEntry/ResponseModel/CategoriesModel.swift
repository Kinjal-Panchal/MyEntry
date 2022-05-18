//
//  CategoriesModel.swift
//  MyEntry
//
//  Created by Kinjal panchal on 20/11/21.
//

import Foundation

class RootCategories : Codable {

        let data : [CategoriesData]?
        let message : String?
        let status : Bool?

        enum CodingKeys: String, CodingKey {
                case data = "data"
                case message = "message"
                case status = "status"
        }
    
    required init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                data = try? values.decodeIfPresent([CategoriesData].self, forKey: .data)
                message = try? values.decodeIfPresent(String.self, forKey: .message)
                status = try? values.decodeIfPresent(Bool.self, forKey: .status)
        }

}

class CategoriesData : Codable {

        let id : Int?
        let mainImage : String?
        let name : String?
        let thumbImage100 : String?
        let thumbImage250 : String?
        let thumbImage50 : String?
        let thumbImage500 : String?

        enum CodingKeys: String, CodingKey {
                case id = "id"
                case mainImage = "main_image"
                case name = "name"
                case thumbImage100 = "thumb_image_100"
                case thumbImage250 = "thumb_image_250"
                case thumbImage50 = "thumb_image_50"
                case thumbImage500 = "thumb_image_500"
        }
    
    required init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try? values.decodeIfPresent(Int.self, forKey: .id)
            mainImage = try? values.decodeIfPresent(String.self, forKey: .mainImage)
            name = try? values.decodeIfPresent(String.self, forKey: .name)
            thumbImage100 = try? values.decodeIfPresent(String.self, forKey: .thumbImage100)
            thumbImage250 = try? values.decodeIfPresent(String.self, forKey: .thumbImage250)
            thumbImage50 = try? values.decodeIfPresent(String.self, forKey: .thumbImage50)
            thumbImage500 = try? values.decodeIfPresent(String.self, forKey: .thumbImage500)
        }

}
