//
//  SearchCoordinator.swift
//  Airports
//
//  Created by Dawid Karpiński on 07/07/2022.
//

import RxSwift

enum SearchCoordinatorResult {
    case findItem(String)
    case cancel
}

class SearchCoordinator: BaseCoordinator<SearchCoordinatorResult>, ICoordinatorInit {
    
    private let rootViewController: UIViewController
    required init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<SearchCoordinatorResult> {
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        let viewModel = SearchViewModel.init(repository: FlighLabsService())
        
        viewController.viewModel = viewModel
        rootViewController.navigationController?.pushViewController(viewController, animated: true)
        return Observable.never()
    }

}
