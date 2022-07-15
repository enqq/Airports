//
//  SearchViewModel.swift
//  Airports
//
//  Created by Dawid Karpiński on 15/07/2022.
//

import RxSwift
import Combine

final class SearchViewModel: ViewModelType {
    
    let input: Input
    let output: Output
    
    struct Input {
        let searchText: AnyObserver<String>
    }
    
    struct Output {
        let cities: Observable<[CityModel]>
    }
    
    private let searchSubject = PublishSubject<String>()
    
    init(repository: FlighLabsService) {
        
        let cityArray = searchSubject
            .distinctUntilChanged()
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .flatMapLatest({ text -> Observable<[CityModel]> in
                return repository.getCity(text)
            })
        
        self.input = Input(searchText: searchSubject.asObserver())
        self.output = Output(cities: cityArray)
    }
    
}
