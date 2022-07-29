//
//  AirportsCoordinator.swift
//  Airports
//
//  Created by Dawid Karpiński on 06/07/2022.
//

import RxSwift

class AirportsCoordinator: BaseCoordinator<Void>, ICoordinatorInit {
    
    private let rootController: UIViewController
    
    required init(rootViewController: UIViewController) {
        self.rootController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        
        let viewModel = AirportsViewModel()
        let viewController = rootController as! AirportViewController
        viewController.viewModel = viewModel
        
        viewModel.output.selectButton
            .flatMapLatest({ [weak self] _  -> Observable<AirportModel> in
                guard let `self` = self else { return .empty() }
                return self.showSearchVC()
            })
            .bind(to: viewModel.input.selectAirport)
            .disposed(by: disposeBag)
        
        viewModel.output.showFlights
            .withLatestFrom(viewModel.output.selectCity.filter({$0.icaoCode != nil}).map({ $0.icaoCode! }))
            .subscribe(onNext: { [weak self] icao in
              _ = self?.showFlightsVC(icaoCode: icao)
            })
            .disposed(by: disposeBag)
           
        return Observable.never()
    }
    
    private func showSearchVC() -> Observable<AirportModel> {
        let searchCoordinator = SearchCoordinator(rootViewController: rootController)
        return coordinate(to: searchCoordinator)
            .map({ result in
                switch result {
                case .findItem(let airport): return airport
                }
            })
    }
    
    private func showFlightsVC(icaoCode: String) -> Observable<Void> {
        let fligtsViewModel = FlightsViewModel(repository: FlighLabsService(), icaoCode: icaoCode)
        let fligtsCoordinator = FlightsCoordinator(rootViewController: rootController)
        fligtsCoordinator.viewModel = fligtsViewModel
        return coordinate(to: fligtsCoordinator)
    }
}
