//
//  EmptyStateViewModel.swift
//  NearbyPlaces
//
//  Created by Alaa on 2/21/20.
//  Copyright © 2020 Cognotev. All rights reserved.
//

import Foundation



class EmptyStateViewModel: NSObject {
    var title:String?
    var stateDescription:String?
    var imageName:String?
    var buttonTitle:String?
    
    var buttonActionClosure: (() -> Void)?
    
    
    init(title:String? = nil,description:String? = nil,imageName:String? = nil,buttonTitle:String? = nil) {
        self.title = title
        self.stateDescription = description
        self.imageName = imageName
        self.buttonTitle = buttonTitle
    }
    
    func buttonAction() {
        if let buttonActionClosure = buttonActionClosure {
            buttonActionClosure()
        }
    }
}
