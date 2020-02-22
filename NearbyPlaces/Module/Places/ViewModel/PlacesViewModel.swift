//
//  PlacesViewModel.swift
//  NearbyPlaces
//
//  Created by Alaa on 2/22/20.
//  Copyright © 2020 Cognotev. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class PlacesViewModel:BaseViewModel {
    
    private let locationManager:LocationManger = LocationManger()
    private let networkManger = PlacesNetworkManger()
    var dataSource = BehaviorRelay<[PlacesCellViewModel]>(value: [])
    var realTime:Bool{
        set{
            UserDefaultsConstant.saveLocationStatus(newValue)
            locationManager.realTime = newValue

        }
        get{
            return UserDefaultsConstant.getLocationStatus() ?? true
        }
    }
    
    override init() {
        super.init()
        locationManager.disallowLocation = { [weak self]meesage in
            guard let self = self else {return}
            self.showLoadingSubject.onNext(false)
            //self?.showAlertError.onNext(.error(meesage))
            self.handleEmptyState(with: meesage)

        }
        locationManager.configureLocation.subscribe(onNext: { [weak self](location) in
            guard let self = self else {return}
            self.configureData(location.coordinate.latitude,location.coordinate.longitude)
            if !self.realTime{
                self.locationManager.realTime = self.realTime
            }

        }).disposed(by: self.bag)
    }
    func startLocation()  {
        locationManager.getCurrenLocation()
    }
    private func configureData(_ lat:Double, _ lon:Double)  {
        
        self.showLoadingSubject.onNext(true)
        self.networkManger.getNearbyPlaces(by: lat, lon: lon, completion: {[weak self] (result) in
            guard let self = self else {return}
            self.showLoadingSubject.onNext(false)
            switch result{
            case .success(let placesModel):self.configureDataSource(placesModel.response)
            case .failure(let error):
                //self?.showAlertError.onNext(error)
                self.handleEmptyState(with: error.localizedDescritpion)
            }
        })
    }
    private func configureDataSource(_ placesModel:PlacesModel?){
        guard let groups = placesModel?.groups , groups.count != 0 else {
            self.handleEmptyState(with: "No Data Found !!" ,imageName: "customWarning")
            return
        }
        var placeCellViewModelArray:[PlacesCellViewModel] = []
        for group in groups {
            if let items = group.items{
                placeCellViewModelArray += items.map{PlacesCellViewModel(model: $0.venue)}
            }
        }
        if placeCellViewModelArray.count == 0{
            self.handleEmptyState(with: "No Data Found !!" ,imageName: "customWarning")
        }
        dataSource.accept(placeCellViewModelArray)
    }
 
}
