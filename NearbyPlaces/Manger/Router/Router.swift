//
//  Router.swift
//  NearbyPlaces
//
//  Created by Alaa on 2/21/20.
//  Copyright © 2020 Cognotev. All rights reserved.
//

import Foundation

enum HttpMethod : String {
    case get = "Get"
    case post = "Post"
}

typealias httpHeaders = [String:String]
typealias httpParameters = [String:String]

protocol Router {
    var path:String{get}
    var baseUrl:String{get}
    var scheme:String{get}
    var method:HttpMethod { get }
    var headers:httpHeaders? { get }
    var baseParameter:httpParameters? { get}
    var parameter:httpParameters? { get}
    var body:httpParameters? { get }
}
extension Router{
    var headers:httpHeaders?{
        return ["content-type":"application/json","Accept":"application/json"]
    }
    var baseParameter:httpParameters?{
        get{
            return ["client_id":"5RM5H4REDZMT5POWJHX0H55M3WSVBS0XJJ5INRFJIWHTJ1FA","client_secret":"NXL2RN0CGIU1DEQAWTID1AOJEP3JUSFOYFXOANQNOCX5A4KT","v":Date().dateString()]
        }
    }
    var baseUrl:String{
        return "api.foursquare.com"
    }
    
    var body:httpParameters?{
        return nil
    }
    
    var scheme:String{
        return "https"
    }
}
