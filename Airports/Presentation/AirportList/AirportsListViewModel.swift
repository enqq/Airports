//
//  AirportsListViewModel.swift
//  Airports
//
//  Created by Dawid Karpiński on 06/07/2022.
//

import Foundation
import RxSwift

final class AirportsListViewModel : IViewModel {
    private var service: FlighLabsService!
    
    var input: Input
    
    var output: Output
    
    struct Input{
        let selectCity = PublishSubject<Void>()
    }
    
    struct Output {
        
    }
    init(service: FlighLabsService = FlighLabsService()){
        self.service = service
        
        self.output = Output()
        self.input = Input()
    }

}
