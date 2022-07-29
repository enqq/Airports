//
//  FlightsCoordinator.swift
//  Airports
//
//  Created by Dawid Karpiński on 20/07/2022.
//

import RxSwift

class FlightsCoordinator: BaseCoordinator<Void>, ICoordinatorInit {
    
    private let rootViewController: UIViewController!
    var viewModel: FlightsViewModel!
    
    required init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        let viewController = storyboard.instantiateViewController(withIdentifier: "FlightsViewController") as! FlightsViewController
        viewController.viewModel = viewModel
        
        rootViewController.navigationController?.show(viewController, sender: nil)
        return Observable.never()
        
    }
}
