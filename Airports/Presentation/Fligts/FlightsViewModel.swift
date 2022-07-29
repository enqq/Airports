//
//  FlightsViewModel.swift
//  Airports
//
//  Created by Dawid Karpiński on 19/07/2022.
//

import RxSwift
import RxCocoa

final class FlightsViewModel: ViewModelType {
    
    let input: Input
    let output: Output
    
    struct Input {
    }
    
    struct Output {
        let flights: Driver<[FlightModel]>
        /// Get starting airport name
        let title: Driver<String>
    }
    
    init(repository: FlighLabsService, icaoCode: String) {
        
        let fligts = repository.getFlights(icaoCode)
            .asDriver(onErrorJustReturn: [])
        
        let title = fligts
            .map({ flightsList -> String in
                guard let airportName =  flightsList.first?.departure?.airport else {return "null"}
                print(airportName)
                return airportName
            })
        
        self.input = Input()
        self.output = Output(flights: fligts, title: title)
    }
}
