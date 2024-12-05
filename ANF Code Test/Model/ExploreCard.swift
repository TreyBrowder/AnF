//
//  ExploreCard.swift
//  ANF Code Test
//
//  Created by Trey Browder on 12/5/24.
//

import Foundation

struct ExploreCard: Codable {
    let title: String
    let backgroundImage: String
    let promoMessage: String?
    let topDescription: String?
    let bottomDescription: String?
    let content: [ContentItem]?
}

struct ContentItem: Codable {
    let target: String
    let title: String
    let elementType: String?
}
