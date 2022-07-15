//
//  FlightLabsService.swift
//  Airports
//
//  Created by Dawid Karpiński on 07/07/2022.
//

import Foundation
import RxSwift
import ObjectMapper

class FlighLabsService {
    
    private let networkManager: NetworkManager
    init(networkManager: NetworkManager = NetworkManager()){
        self.networkManager = networkManager
        
    }
    
    func getCity(_ searchValue: String) -> Observable<[CityModel]> {
        let url = URL.init(string: "\(baseUrl)cities?access_key=\(apiKey)&search=\(searchValue)")
        return  networkManager.getData(url!).flatMapLatest { result -> Observable<[CityModel]> in
            switch result {
            case .success(let data):
                
                guard let json = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
                    return Observable.empty()
                }
                let model = json.compactMap { CityModel.init(JSON: $0)}
                return Observable.just(model)
                
            default:
                 fatalError("Error")
            }
        }
    
    }
    
    private let baseUrl = "https://app.goflightlabs.com/"
    private let apiKey = ""
    
}
