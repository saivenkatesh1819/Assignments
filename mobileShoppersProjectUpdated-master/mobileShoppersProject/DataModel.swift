//
//  DataModel.swift
//  mobileShoppersProject
//
//  Created by Amruth Kallyam on 5/7/25.
//

import Foundation

struct DataModel: Decodable {
    let title: String
    let backgroundImage: String
    let content: [Content]?
    let promoMessage: String?
    let bottomDescription: String?
    let topDescription: String?

}
struct Content: Decodable {
    let title: String
    let target: String
}
