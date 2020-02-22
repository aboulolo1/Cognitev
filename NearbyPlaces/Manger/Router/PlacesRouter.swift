//
//  PlacesRouter.swift
//  NearbyPlaces
//
//  Created by Alaa on 2/21/20.
//  Copyright © 2020 Cognotev. All rights reserved.
//

import Foundation
enum PlacesEndPoint {
    case getNearbyPlaces(lat:Double,lon:Double)
    case getPlacePhoto(venueId:String)
}
struct PlacesRouter: Router {
    
    var endPoint:PlacesEndPoint
    
    init(endPoint:PlacesEndPoint) {
        self.endPoint = endPoint
    }
    
    var path: String
    {
        switch endPoint {
        case .getNearbyPlaces:
            return "/v2/venues/explore"
        case .getPlacePhoto(let venueId):
            return "/v2/venues/" + "\(venueId)" + "/photos"
        }
    }
    
    var method: HttpMethod{
        switch endPoint {
        case .getNearbyPlaces,.getPlacePhoto:
            return .get
        }
    }
    
    var parameter: httpParameters?
    {
        switch endPoint {
        case .getNearbyPlaces(let lat,let lon):
            var mutableParamter = baseParameter
            mutableParamter?["ll"] = "\(lat)" + "," + "\(lon)"
            return mutableParamter
        case .getPlacePhoto:
            return baseParameter
        }
    }
}
