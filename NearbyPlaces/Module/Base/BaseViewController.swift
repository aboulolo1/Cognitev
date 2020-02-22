//
//  ViewController.swift
//  NearbyPlaces
//
//  Created by Alaa on 2/21/20.
//  Copyright © 2020 Cognotev. All rights reserved.
//

import UIKit
import RxSwift
import SVProgressHUD
import SwiftMessageBar

class BaseViewController: UIViewController {

    var baseViewModel:BaseViewModel?
    var emptyStateViewContainer: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func configureUI()  {
        emptyStateViewContainer = UIView(frame: self.view.bounds)
        emptyStateViewContainer.isHidden = true
        self.view.addSubview(emptyStateViewContainer)
        emptyStateViewContainer.fillSuperview()
        
    }
    
    func configureBinding()  {
        baseViewModel?.showLoadingSubject.observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: {(isLoading) in
                if isLoading{
                    SVProgressHUD.show(withStatus: "Loading...")
                }
                else {
                    SVProgressHUD.dismiss()
                }
            })
            .disposed(by: baseViewModel?.bag ?? DisposeBag())
        
        baseViewModel?.showAlertError.observeOn(MainScheduler.instance).subscribe(onNext: {  (apiError) in
            SwiftMessageBar.showMessage(withTitle: "Error", message: apiError.localizedDescritpion , type: .error)

        }).disposed(by: baseViewModel?.bag ?? DisposeBag())
        
        
        
        baseViewModel?.showEmptyStateSubject.observeOn(MainScheduler.instance).subscribe(onNext: {  [weak self](viewModel) in
            let loadingView = EmptyStateView.emptyStateView(viewModel: viewModel, frame: (self?.emptyStateViewContainer.bounds)!)
            self?.emptyStateViewContainer.addSubview(loadingView)
            self?.emptyStateViewContainer.isHidden = false
            self?.emptyStateViewContainer.backgroundColor = .white
        }).disposed(by: baseViewModel?.bag ?? DisposeBag())
        
        
    }

    
}

