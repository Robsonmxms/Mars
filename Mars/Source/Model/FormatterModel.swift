//
//  FormatterModel.swift
//  Mars
//
//  Created by Robson Lima Lopes on 26/08/22.
//

import Foundation

struct FormatterModel {
    static func dateFormatter(_ date: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterSet = DateFormatter()
        dateFormatterSet.dateFormat = "MMM dd, yyyy"
        if let formattedDate = dateFormatterGet.date(from: date) {
            return dateFormatterSet.string(from: formattedDate)
        } else {
           return date
        }
    }
}
