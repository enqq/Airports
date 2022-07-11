//
//  AirportsListCoordinator.swift
//  Airports
//
//  Created by Dawid Karpiński on 06/07/2022.
//

import RxSwift

class AirportsListCoordinator : BaseCoordinator<Void>, ICoordinatorInit {
    
    private let rootController: UIViewController
    
    required init(rootViewController: UIViewController) {
        self.rootController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        
        let viewModel = AirportsListViewModel()
        let viewController = rootController as! AirportListViewController
        viewController.viewModel = viewModel
        
        viewModel.input.selectCity
            .subscribe(onNext: { [weak self] _ in
               _ = self?.showSearchVC()
            }).disposed(by: disposeBag)
        
        
        return Observable.never()
    }
    
    private func showSearchVC() -> Observable<SearchCoordinatorResult> {
        let searchCoordinator = SearchCoordinator(rootViewController: rootController)
        return coordinate(to: searchCoordinator)
    }
}
