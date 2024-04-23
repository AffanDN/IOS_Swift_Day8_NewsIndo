//
//  String+ExtDate.swift
//  NewsIndo
//
//  Created by Macbook Pro on 23/04/24.
//

import Foundation

extension String {
    // case "19 Menit yang lalu" -> relativeCurrentDate
    func relativeToCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "id_ID")
        // 2024-04-22T23:52:46.000Z" = yyyy-MM-dd'T'HH:mm:sssZ
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        // butuh string dari data
        guard let date = dateFormatter.date(from: self) else {
            return ""
        }
        
        let now = Date()
        let calendar = Calendar.current
        
        let component = calendar.dateComponents([.year, .month, .weekOfMonth, .day, .hour, .minute], from: date, to: now)
        
        // logic 19 menit yang lalu
        if let year = component.year, year > 0 {
            return"\(year) tahun yang lalu"
        } else if let month = component.month, month > 0 {
            return "\(month) bulan yang lalu"
        }else if let week = component.weekOfMonth, week > 0 {
            return "\(week) minggu yang lalu"
        }else if let day = component.day, day > 0 {
            return "\(day) hari yang lalu"
        }else if let hour = component.hour, hour > 0 {
            return "\(hour) jam yang lalu"
        }else if let minute = component.minute, minute > 0 {
            return "\(minute) menit yang lalu"
        } else {
            return "Baru Saja"
        }
    }
}
