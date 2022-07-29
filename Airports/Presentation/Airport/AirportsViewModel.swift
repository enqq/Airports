//
//  AirportsViewModel.swift
//  Airports
//
//  Created by Dawid Karpiński on 06/07/2022.
//

import RxSwift
import RxCocoa

final class AirportsViewModel: ViewModelType {
        
    var input: Input
    
    var output: Output
    
    struct Input {
        /// Taped select button
        let selectButton: AnyObserver<Void>
        /// Return current set airport
        let selectAirport: AnyObserver<AirportModel>
        /// Taped button Airports
        let fligtsButton: AnyObserver<Void>
    }
    
    struct Output {
        /// Emits taped Select Button to display SearchVC
        let selectButton: Observable<Void>
        /// Get Current Airport
        let selectCity: Driver<AirportModel>
        /// Emits Taped Flights button to display FlightsVC
        let showFlights: Observable<Void>
    }
    
    private let selectButtonPublish = PublishSubject<Void>()
    private let selectPublish = PublishSubject<AirportModel>()
    private let fligtsButtonPublish = PublishSubject<Void>()
    
    init(repository: FlighLabsService = FlighLabsService()) {
        
        let selectDriver = selectPublish
            .asDriver(onErrorJustReturn: AirportModel.init())
            
        self.output = Output(selectButton: selectButtonPublish.asObservable(),
                             selectCity: selectDriver,
                             showFlights: fligtsButtonPublish.asObservable()
        )
        
        self.input = Input(selectButton: selectButtonPublish.asObserver(),
                           selectAirport: selectPublish.asObserver(),
                           fligtsButton: fligtsButtonPublish.asObserver()
        )
        
    }

}
