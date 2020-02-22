//
//  BaseModel.swift
//  NearbyPlaces
//
//  Created by Alaa on 2/22/20.
//  Copyright © 2020 Cognotev. All rights reserved.
//

import Foundation

struct BaseModel<T:Codable> : Codable {
    
    let response : T?
    
}
