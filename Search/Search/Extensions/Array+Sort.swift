//
//  Array+Sort.swift
//  Search
//
//  Created by Bella Wei on 8/6/21.
//

import Foundation

extension Array where Element == Result {
    func sortResult() -> Self {
        return sorted { $0.data[0].date_created > $1.data[0].date_created }
    }
}
