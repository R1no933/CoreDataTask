//
//  Date+Ext.swift
//  CoreDataTask
//
//  Created by Dmitriy Baskakov on 12.09.2022.
//

import Foundation

extension Date {
    func convertToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: self)
    }
}
