//
//  EmptyStateView.swift
//  NearbyPlaces
//
//  Created by Alaa on 2/21/20.
//  Copyright © 2020 Cognotev. All rights reserved.
//

import UIKit

class EmptyStateView: UIView {
    
    //MARK:- IBOutlets
    @IBOutlet weak var defaultEmptyStateView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    static func emptyStateView(viewModel:EmptyStateViewModel,frame:CGRect) -> EmptyStateView{
        if let view = Bundle.main.loadNibNamed("EmptyStateView", owner: self, options: nil)?.last as? EmptyStateView{
            view.frame = frame
            view.viewModel = viewModel
            return view
        }
        return EmptyStateView()
    }
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    
    
    //MARK:- Variables
    var viewModel:EmptyStateViewModel!{
        didSet{
            bindUI()
        }
    }
    
    //MARK:- Helper Methods
    func configureUI(){
        backgroundColor = .white
    }
    
    
    
    func bindUI(){
        configureDefaultView()
    }
    
  
    func configureDefaultView(){
        if let imageName = viewModel.imageName{
            imageView.image = UIImage(named: imageName)
        }
        else{
            imageView.isHidden = true
        }
        
        if let title = viewModel.title{
            titleLabel.text = title
        }
        else{
            titleLabel.isHidden = true
        }
        
        if let description = viewModel.stateDescription{
            descriptionLabel.text = description
        }
        else{
            descriptionLabel.isHidden = true
        }
        
        if let buttonTitle = viewModel.buttonTitle{
            button.setTitle(buttonTitle, for: .normal)
        }
        else{
            button.isHidden = true
        }
    }
    
    //MARK:- Actions
    @IBAction func buttonAction(_ sender: Any) {
        viewModel.buttonAction()
    }
}
