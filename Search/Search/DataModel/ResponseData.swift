//
//  ResponseData.swift
//  Search
//
//  Created by Bella Wei on 8/4/21.
//

import Foundation

struct APIResponse: Codable {
    var collection: collection
}

// MARK: - Results

struct collection: Codable {
    var items: [Result]
}

struct Result: Codable {
    var links: [Link]?
    var data: [Datas]
}

struct Datas: Codable {
    var title: String
    var description: String
    var date_created: String
    var keywords: [String]?
    var nasa_id: String?
}

struct Link: Codable {
    var href: String?
    var rel: String
    var render: String
}
