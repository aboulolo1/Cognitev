//
//  PlacesTableViewCell.swift
//  NearbyPlaces
//
//  Created by Alaa on 2/22/20.
//  Copyright © 2020 Cognotev. All rights reserved.
//

import UIKit
import SDWebImage
import RxSwift
import SwiftMessageBar

class PlacesTableViewCell: UITableViewCell {

    @IBOutlet weak var placesImage: UIImageView!
    
    @IBOutlet weak var placeName: UILabel!
    
    @IBOutlet weak var placeAddress: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var viewModel:PlacesCellViewModel!{
        didSet{
            configureBinding()
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        viewModel.bag = DisposeBag()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    private func configureBinding(){
        viewModel.indicatorSubject.observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: {[weak self](isLoading) in
                if isLoading{
                    self?.placesImage.isHidden = true
                    self?.indicator.startAnimating()
                }
                else {
                    self?.placesImage.isHidden = false
                    self?.indicator.stopAnimating()
                }
            })
            .disposed(by: viewModel.bag)
        
        viewModel.errorSubject.observeOn(MainScheduler.instance).subscribe(onNext: {  (message) in
            SwiftMessageBar.showMessage(withTitle: "Error", message: message , type: .error)
            
        }).disposed(by: viewModel.bag)
        
        viewModel.photoUrlSubject.observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] (url) in
            self?.placesImage.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "profileIcon"))

        }).disposed(by: viewModel.bag)
    }
    private func updateView()
    {
        if viewModel.urlPhoto == nil{
            viewModel.getPhoto()
        }
        
        placeName.text = viewModel.name
        placeAddress.text = viewModel.address
        if indicator.isAnimating{
            placesImage.isHidden = true
        }
        else{
            placesImage.isHidden = false
        }

    }
}
