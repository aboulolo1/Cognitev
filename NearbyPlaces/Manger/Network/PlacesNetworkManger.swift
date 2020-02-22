//
//  PlacesNetworkManger.swift
//  NearbyPlaces
//
//  Created by Alaa on 2/21/20.
//  Copyright © 2020 Cognotev. All rights reserved.
//

import Foundation

class PlacesNetworkManger:NetworkManger {
    typealias placesHanlder = (Result<BaseModel<PlacesModel>,ApiError>)->Void
    typealias photosHanlder = (Result<BaseModel<PhotoModel>,ApiError>)->Void

    func getNearbyPlaces(by lat:Double,lon:Double,completion:@escaping placesHanlder)  {
        let router = PlacesRouter(endPoint: .getNearbyPlaces(lat: lat, lon: lon))
        self.performNetworRequest(router: router) { (result) in
            completion(result)
        }
    }
    
    func getPlacePhotos(by venueId:String,completion:@escaping photosHanlder)  {
        let router = PlacesRouter(endPoint: .getPlacePhoto(venueId: venueId))
        self.performNetworRequest(router: router) { (result) in
            completion(result)
        }

    }
}
