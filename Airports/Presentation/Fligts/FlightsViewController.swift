//
//  FlightsViewController.swift
//  Airports
//
//  Created by Dawid Karpiński on 19/07/2022.
//

import UIKit
import RxSwift
import RxCocoa

class FlightsViewController: UIViewController {

    /// Depedencies
    var viewModel: FlightsViewModel!
    private let disposeBag = DisposeBag()
    
    /// Properties
    @IBOutlet weak var flightsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindCollection()
    }
}
// MARK: - Setup View
extension FlightsViewController {
    private func setupView() {
        viewModel.output.title
            .drive(self.rx.title)
            .disposed(by: disposeBag)
    }
}
// MARK: - Binding CollectionView
extension FlightsViewController {
    private func bindCollection() {
        registerCell()
        
        viewModel.output.flights
            .drive(flightsCollectionView.rx.items(cellIdentifier: "flightCell", cellType: FlightCollectionViewCell.self)) { (_, flight, cell) in
                cell.setCell(flight.arrival!.airport!, flight.arrival!.getDataAsString(), flight.departure!.getDataAsString(), flight.flightStatus!)
            }
            .disposed(by: disposeBag)
    }
    
    private func registerCell() {
        flightsCollectionView.register(UINib.init(nibName: "FlightCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "flightCell")
    }
}

// MARK: - CollectionView Delegate
extension FlightsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        let screenWidth = UIScreen.main.bounds.width
        let width = screenWidth - 20
        let height = screenWidth - 40
        
        return CGSize.init(width: width, height: height)
    }
}
