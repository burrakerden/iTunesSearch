//
//  String+Extension.swift
//  iTunesSearch
//
//  Created by Burak Erden on 14.02.2023.
//

import Foundation

//MARK: - DATE FORMATTER
extension String {
    func dateFormaater(dateToChange: String) -> String {
        let string = String(dateToChange)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: string)!
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
