//
//  SearchViewModel.swift
//  Airports
//
//  Created by Dawid Karpiński on 15/07/2022.
//

import RxSwift
import Combine
import RxCocoa

final class SearchViewModel: ViewModelType {
    
    let input: Input
    let output: Output
    
    struct Input {
        let searchText: AnyObserver<String>
        let selectAirport: AnyObserver<AirportModel>
    }
    
    struct Output {
        let airports: Driver<[AirportModel]>
        let didSelectAirport: Observable<AirportModel>
    }
    
    private let searchSubject = PublishSubject<String>()
    private let selectSubject = PublishSubject<AirportModel>()
    
    init(repository: FlighLabsService) {
        
        let airportsDriver = searchSubject
            .distinctUntilChanged()
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .flatMapLatest({ text -> Observable<[AirportModel]> in
                return repository.getAirports(text)
            })
            .asDriver(onErrorJustReturn: [])
        
        self.input = Input(searchText: searchSubject.asObserver(), selectAirport: selectSubject.asObserver())
        self.output = Output(airports: airportsDriver, didSelectAirport: selectSubject.asObservable())
    
    }
    
}
