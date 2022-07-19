//
//  AirportsListViewController.swift
//  Airports
//
//  Created by Dawid Karpiński on 06/07/2022.
//

import UIKit
import RxSwift
import RxCocoa

class AirportListViewController: UIViewController {

    @IBOutlet weak var airportsCollectionView: UICollectionView!
    @IBOutlet weak var airportNameLabel: UILabel!
    @IBOutlet weak var iataCodeLabel: UILabel!
    @IBOutlet weak var icaoCodeLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    
    var viewModel: AirportsListViewModel!
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindNaviItem()
        bindSetup()
    }

}

// MARK: - Binding with navigation
extension AirportListViewController {
    private func bindNaviItem() {
        selectButton.rx.tap
            .bind(to: viewModel.input.selectButton)
            .disposed(by: disposeBag)
    }
}

// MARK: - SetupView
extension AirportListViewController {
    private func bindSetup() {

        viewModel.output.selectCity
            .map({ $0.airportName })
            .drive(airportNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.selectCity
            .map({ $0.iataCode })
            .drive(iataCodeLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.selectCity
            .map({ $0.icaoCode })
            .drive(icaoCodeLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.selectCity
            .map({ $0.countryName })
            .drive(countryNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.selectCity
            .map({ $0.phoneNumber })
            .drive(phoneNumberLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.selectCity
            .map({ $0.latitude })
            .drive(latitudeLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.selectCity
            .map({ $0.longitude })
            .drive(longitudeLabel.rx.text)
            .disposed(by: disposeBag)
        
    }
}
