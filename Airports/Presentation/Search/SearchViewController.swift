//
//  SearchViewController.swift
//  Airports
//
//  Created by Dawid Karpiński on 07/07/2022.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {

    var viewModel: SearchViewModel!
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var citiesTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
        tableViewBindings()
    }
}

// MARK: - ViewController bind with ViewModel
extension SearchViewController {
    func setupBindings() {
        searchBar.rx.text
            .orEmpty
            .bind(to: viewModel.input.searchText)
            .disposed(by: disposeBag)
    }
}

// MARK: - Get data to TableView
extension SearchViewController {
    func tableViewBindings() {
        registerCell()
        
        viewModel.output.cities
            .bind(to: citiesTableView.rx.items(cellIdentifier: "cityCell", cellType: CityTableViewCell.self)) { ( _, city, cell ) in
                cell.setCell(country: city.iataCode!, city: city.cityName!)
            }.disposed(by: disposeBag)
        
    }
    
    func registerCell() {
        let nib = UINib(nibName: "CityTableViewCell", bundle: nil)
        self.citiesTableView.register(nib, forCellReuseIdentifier: "cityCell")
    }
}
