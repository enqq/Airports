//
//  AirportsListViewModel.swift
//  Airports
//
//  Created by Dawid Karpiński on 06/07/2022.
//

import RxSwift
import RxCocoa

final class AirportsListViewModel: ViewModelType {
        
    var input: Input
    
    var output: Output
    
    struct Input {
        /// Taped select button
        let selectButton: AnyObserver<Void>
        /// Return current set airport
        let selectAirport: AnyObserver<AirportModel>
    }
    
    struct Output {
        /// Emits taped Select Button to display SearchView
        let selectButton: Observable<Void>
        /// Get Current Airport
        let selectCity: Driver<AirportModel>
    }
    
    private let selectButtonPublish = PublishSubject<Void>()
    private let selectPublish = PublishSubject<AirportModel>()
    
    init(repository: FlighLabsService = FlighLabsService()) {
        
        let selectDriver = selectPublish
            .asDriver(onErrorJustReturn: AirportModel.init())
            
        self.output = Output(selectButton: selectButtonPublish.asObservable(), selectCity: selectDriver)
        self.input = Input(selectButton: selectButtonPublish.asObserver(), selectAirport: selectPublish.asObserver())
        
    }

}
