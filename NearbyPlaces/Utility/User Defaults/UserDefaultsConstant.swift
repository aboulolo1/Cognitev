//
//  UserDefaults.swift
//  NearbyPlaces
//
//  Created by Alaa on 2/22/20.
//  Copyright © 2020 Cognotev. All rights reserved.
//

import Foundation

class UserDefaultsConstant {
    static func saveLocationStatus(_ realTime:Bool){
        UserDefaults.standard.setValue(realTime, forKey: "realTime")
        UserDefaults.standard.synchronize()
    }
    
    static func getLocationStatus()->Bool?{
        return UserDefaults.standard.object(forKey: "realTime") as? Bool
    }
}
