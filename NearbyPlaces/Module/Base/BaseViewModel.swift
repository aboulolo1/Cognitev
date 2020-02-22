//
//  BaseViewModel.swift
//  NearbyPlaces
//
//  Created by Alaa on 2/21/20.
//  Copyright © 2020 Cognotev. All rights reserved.
//

import Foundation
import RxSwift

class BaseViewModel {
    
    let bag = DisposeBag()
    let showAlertError = PublishSubject<ApiError>()
    let showLoadingSubject = PublishSubject<Bool>()
    let showEmptyStateSubject = PublishSubject<EmptyStateViewModel>()
    
    func handleEmptyState(with message: String = "No Data Found",imageName:String = "closeOTPIcon") {
        let emptyStateViewModel = EmptyStateViewModel(title: nil, description: message, imageName:imageName , buttonTitle: nil)
        showEmptyStateSubject.onNext(emptyStateViewModel)
    }

}
