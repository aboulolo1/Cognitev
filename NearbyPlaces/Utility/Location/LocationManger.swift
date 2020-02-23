//
//  LocationManger.swift
//  NearbyPlaces
//
//  Created by Alaa on 2/22/20.
//  Copyright © 2020 Cognotev. All rights reserved.
//

import UIKit
import CoreLocation
import RxSwift

class LocationManger:NSObject,CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    private var myLocation:CLLocation?
    var realTime:Bool = true{
        didSet{
            if !realTime{
                locationManager.stopMonitoringSignificantLocationChanges()
                locationManager.delegate = nil
            }
            else{
                locationManager.delegate = self
                locationManager.startMonitoringSignificantLocationChanges()
            }
        }
    }
    
    override init() {
        super.init()
    }
    
    var disallowLocation:((String)->())?
    var configureLocation = PublishSubject<CLLocation>()
    func getCurrenLocation()  {
        let status = CLLocationManager.authorizationStatus()
        
        if(status == .denied || status == .restricted || status == .notDetermined || !CLLocationManager.locationServicesEnabled()){
            locationManager.requestAlwaysAuthorization()
            
        }
            locationManager.delegate = self
            locationManager.distanceFilter = 500
            locationManager.allowsBackgroundLocationUpdates = true
            locationManager.startMonitoringSignificantLocationChanges()

    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            if let loc = self.myLocation {
                if loc.coordinate.latitude == location.coordinate.latitude && loc.coordinate.longitude == location.coordinate.longitude{
                    return
                }
            }
            self.myLocation = location
            configureLocation.onNext(location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("location manager authorization status changed")
        
        switch status {
        case .authorizedAlways:
            print("user allow app to get location data when app is active or in background")

        case .authorizedWhenInUse:
            print("user allow app to get location data only when app is active")

        case .denied:
            print("user tap 'disallow' on the permission dialog, cant get location data")
            disallowLocation?("user tap 'disallow' on the permission dialog, cant get location data")
        case .restricted:
            print("parental control setting disallow location data")
        case .notDetermined:
            print("the location permission dialog haven't shown before, user haven't tap allow/disallow")
        }
    }
    
}
