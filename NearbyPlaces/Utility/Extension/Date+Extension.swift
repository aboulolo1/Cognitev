//
//  Date+Extension.swift
//  NearbyPlaces
//
//  Created by Alaa on 2/21/20.
//  Copyright © 2020 Cognotev. All rights reserved.
//

import Foundation

extension Date {
    func dateString(with formate:String = "yyyyMMdd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        return dateFormatter.string(from: self)
    }
    
   
}
