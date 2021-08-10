//
//  ViewModel.swift
//  Search
//
//  Created by Bella Wei on 8/4/21.
//

import Foundation

struct SearchViewModel: Hashable {
    let identifier = UUID()
    var result: Result

    var data: [Datas] {
        result.data
    }

    var links: [Link]? {
        result.links
    }

    var thumbnailUrl: String? {
        links![0].href
    }

    var title: String {
        data[0].title
    }

    var description: String {
        data[0].description
    }

    var createDate: String {
        let dateformatter = ISO8601DateFormatter()
        let date = dateformatter.date(from: data[0].date_created)
        return DateFormatter(locale: .current, format: "MMM dd, yyyy hh:mm a zzz").string(from: date!)
    }

    init(result: Result) {
        self.result = result
    }

    func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }

    static func == (lhs: SearchViewModel, rhs: SearchViewModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
