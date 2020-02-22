//
//  ApiError.swift
//  NearbyPlaces
//
//  Created by Alaa on 2/21/20.
//  Copyright © 2020 Cognotev. All rights reserved.
//

import Foundation

enum ApiError:Error {
    case noData
    case invalidData
    case noConnetion
    case noDataCached
    case serviceUnAvailable
    case error(String)
}
extension ApiError
{
    var localizedDescritpion:String{
        switch self {
        case .noData:
            return "No Data Found!!"
        case .invalidData:
            return "Invaild Data"
        case .noConnetion:
            return "No Internet Connection"
        case .error(let err):
            return err
        case .noDataCached:
            return "No Data Cached"
        case .serviceUnAvailable:
            return "Something went wrong!!"
            
        }
    }
}
