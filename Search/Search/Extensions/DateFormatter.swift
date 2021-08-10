//
//  DateFormatter.swift
//  Search
//
//  Created by Bella Wei on 8/8/21.
//

import Foundation

extension DateFormatter {
    convenience init(locale: Locale, format: String) {
        self.init()
        self.locale = locale
        dateFormat = format
    }
}
