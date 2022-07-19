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

// MARK: - Get data & Select Item - TableView
extension SearchViewController {
    func tableViewBindings() {
        registerCell()
        tapTableRow()
        
        viewModel.output.airports
            .drive( citiesTableView.rx.items(cellIdentifier: "airportCell", cellType: AirportTableViewCell.self)) { ( _, airport, cell ) in
                cell.setCell(airport.iataCode!, "dd", airport.airportName!, airport.countryIso2!)
            }
            .disposed(by: disposeBag)
        
    }
    
    /// Bind select cell to ViewModel
    func tapTableRow() {
        citiesTableView.rx.modelSelected(AirportModel.self)
            .bind(to: viewModel.input.selectAirport)
            .disposed(by: disposeBag)
    }
    
    func registerCell() {
        let nib = UINib(nibName: "AirportTableViewCell", bundle: nil)
        self.citiesTableView.register(nib, forCellReuseIdentifier: "airportCell")
    }
}
