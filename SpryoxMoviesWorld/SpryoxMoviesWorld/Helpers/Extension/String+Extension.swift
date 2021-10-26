//
//  String+Extension.swift
//  SpryoxMoviesWorld
//
//  Created by Irshad Qureshi on 26/10/2021.
//

import Foundation

extension String {
    func getformattedDate() -> String {
        let serverDateFormat = DateFormatter()
        serverDateFormat.dateFormat = "YYYY-MM-DD hh:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        guard let date = serverDateFormat.date(from: self) else { return self  }
        return dateFormatter.string(from: date)
    }
}
