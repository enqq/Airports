//
//  AppCoordinator.swift
//  Airports
//
//  Created by Dawid Karpiński on 06/07/2022.
//

import RxSwift

class AppCoordinator: BaseCoordinator<Void> {
   
    var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let viewController = storyboard.instantiateViewController(withIdentifier: "AirportsViewController") as! AirportViewController
        
        let navigationController = UINavigationController.init(rootViewController: viewController)
        let coordinator = AirportsCoordinator(rootViewController: navigationController.viewControllers[0])
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return coordinate(to: coordinator)
    }
}
