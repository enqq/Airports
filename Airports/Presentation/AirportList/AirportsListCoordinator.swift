//
//  AirportsListCoordinator.swift
//  Airports
//
//  Created by Dawid Karpiński on 06/07/2022.
//

import RxSwift

class AirportsListCoordinator: BaseCoordinator<Void>, ICoordinatorInit {
    
    private let rootController: UIViewController
    
    required init(rootViewController: UIViewController) {
        self.rootController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        
        let viewModel = AirportsListViewModel()
        let viewController = rootController as! AirportListViewController
        viewController.viewModel = viewModel
        
        viewModel.output.selectButton
            .flatMapLatest({ [weak self] _  -> Observable<AirportModel> in
                guard let `self` = self else { return .empty() }
                return self.showSearchVC()
            })
            .bind(to: viewModel.input.selectAirport)
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
}
