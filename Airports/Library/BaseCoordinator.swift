//
//  BaseCoordinator.swift
//  Airports
//
//  Created by Dawid Karpiński on 06/07/2022.
//

import Foundation
import RxSwift

class BaseCoordinator<ResultType> {
    
    public typealias CoordinationResult = ResultType

        public let disposeBag = DisposeBag()
        public let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
    
        private let identifier = UUID()
        private var childCoordinators = [UUID: Any]()

        private func store<T>(coordinator: BaseCoordinator<T>) {
            childCoordinators[coordinator.identifier] = coordinator
        }

        private func release<T>(coordinator: BaseCoordinator<T>) {
            childCoordinators[coordinator.identifier] = nil
        }

        @discardableResult
        open func coordinate<T>(to coordinator: BaseCoordinator<T>) -> Observable<T> {
            store(coordinator: coordinator)
            return coordinator.start()
                .do(onNext: { [weak self] _ in
                    self?.release(coordinator: coordinator) })
        }

        open func start() -> Observable<ResultType> {
            fatalError("start() method must be implemented")
        }
}

