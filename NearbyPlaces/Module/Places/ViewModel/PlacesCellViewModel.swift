//
//  PlacesCellViewModel.swift
//  NearbyPlaces
//
//  Created by Alaa on 2/22/20.
//  Copyright © 2020 Cognotev. All rights reserved.
//

import Foundation
import RxSwift

class PlacesCellViewModel {

    var bag = DisposeBag()
    var indicatorSubject = PublishSubject<Bool>()
    var photoUrlSubject = PublishSubject<String>()
    var errorSubject = PublishSubject<String>()
    var urlPhoto:String?
    var name:String{
        if let name = model?.name{
            return name
        }
        return ""
    }
    var address:String{
        if let address = model?.location?.formattedAddress{
            return address.reduce("", +)
        }
        return ""
    }
    var model:Venue?
    init(model:Venue?) {
        self.model = model
    }
    
    func getPhoto()  {
        indicatorSubject.onNext(true)
        PlacesNetworkManger().getPlacePhotos(by: model?.id ?? "") {[weak self] (result) in
            self?.indicatorSubject.onNext(false)
            switch result{
                case .success(let model):self?.configurePhotUrl(model.response)
            case .failure(let err):
                self?.errorSubject.onNext(err.localizedDescritpion)
            }
        }
    }
    private func configurePhotUrl(_ photoModel:PhotoModel?) {
        if let photo = photoModel?.photos?.items?.first{
            urlPhoto = (photo.prefix ?? "") + "100x100" + (photo.suffix ?? "")
            photoUrlSubject.onNext(urlPhoto!)
        }
    }
}
