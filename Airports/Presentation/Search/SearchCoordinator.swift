//
//  SearchCoordinator.swift
//  Airports
//
//  Created by Dawid Karpiński on 07/07/2022.
//

import RxSwift

enum SearchCoordinatorResult {
    case findItem(AirportModel)
}

class SearchCoordinator: BaseCoordinator<SearchCoordinatorResult>, ICoordinatorInit {
    
    private let rootViewController: UIViewController
    required init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<SearchCoordinatorResult> {
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        let viewModel = SearchViewModel.init(repository: FlighLabsService())
        
        let findItem = viewModel.output.didSelectAirport.map({ SearchCoordinatorResult.findItem($0)})
        
        viewController.viewModel = viewModel
        rootViewController.navigationController?.pushViewController(viewController, animated: true)
        return findItem
            .take(1)
            .do(onNext: {[weak self] _ in
                self?.rootViewController.navigationController?.popViewController(animated: true)
            })
    }

}
