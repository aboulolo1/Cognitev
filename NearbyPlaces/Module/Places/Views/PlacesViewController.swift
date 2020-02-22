//
//  PlacesViewController.swift
//  NearbyPlaces
//
//  Created by Alaa on 2/21/20.
//  Copyright © 2020 Cognotev. All rights reserved.
//

import UIKit
import RxSwift

class PlacesViewController: BaseViewController {

    @IBOutlet weak var locationStatusBtn: UIBarButtonItem!
    @IBOutlet weak var placesTableView: UITableView!
    var viewModel:PlacesViewModel!
    override var baseViewModel: BaseViewModel!{
        didSet{
            self.viewModel = (baseViewModel as? PlacesViewModel)!
        }
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseViewModel = PlacesViewModel()
        configureBinding()
        configureUI()
        viewModel.startLocation()
    }
    override func configureUI() {
        super.configureUI()
        placesTableView.tableFooterView = UIView()
        placesTableView.register(UINib(nibName: "PlacesTableViewCell", bundle: nil), forCellReuseIdentifier: "PlacesTableViewCell")
       configureLocationStatusBtn()

    }
    private func configureLocationStatusBtn(){
        if viewModel.realTime{
            self.locationStatusBtn.title = "RealTime"
        }
        else{
            self.locationStatusBtn.title = "Single Update"
        }
    }
    override func configureBinding() {
        super.configureBinding()
        viewModel.dataSource.bind(to: placesTableView.rx.items(cellIdentifier: "PlacesTableViewCell",cellType: PlacesTableViewCell.self)) { row, cellViewModel, cell in
            cell.viewModel = cellViewModel
            }.disposed(by: viewModel.bag)
        
    }

    @IBAction func locationStatusAction(_ sender: Any) {
        viewModel.realTime = !viewModel.realTime
        configureLocationStatusBtn()
    }
}
