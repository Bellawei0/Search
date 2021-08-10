//
//  EndPoint.swift
//  Search
//
//  Created by Bella Wei on 8/4/21.
//

import Foundation

enum EndPoint {
    static let base = "http://images-api.nasa.gov/search?q="
    static let apiKeyParam = "&media_type=image"

    case exampleSearch
    case querySearch(String)

    var stringValue: String {
        switch self {
        case .exampleSearch:
            return EndPoint.base + "mars" + EndPoint.apiKeyParam
        case let .querySearch(query):
            return EndPoint.base + "\(query)" + EndPoint.apiKeyParam
        }
    }

    var url: URL {
        return URL(string: stringValue)!
    }
}
