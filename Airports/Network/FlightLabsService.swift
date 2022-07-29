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
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
        
    }
    
    /// Get airports find by search text
    func getAirports(_ searchText: String) -> Observable<[AirportModel]> {
        let url = URL.init(string: "\(baseUrl)airports?access_key=\(apiKey)&search=\(searchText)")
        return networkManager.getData(url!)
            .flatMapLatest { result -> Observable<[AirportModel]> in
                switch result {
                case .success(let data):
                    guard let json = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
                        return Observable.empty()
                    }
                    let model = json.compactMap({ AirportModel.init(JSON: $0) })
                    return Observable.just(model)
                default:
                    fatalError("Error")
                }
            }
    }
    
    /// Get Fligts by Icao Code
    func getFlights(_ icaoCode: String) -> Observable<[FlightModel]> {
        let url = URL.init(string: "\(baseUrl)flights?access_key=\(apiKey)&dep_icao=\(icaoCode)")
        return networkManager.getData(url!)
            .flatMap({ result -> Observable<[FlightModel]> in
                switch result {
                case .success(let data):
                    guard let json = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
                        return Observable.empty()
                    }
                    let flights = json.compactMap({ FlightModel.init(JSON: $0) })
                  return Observable.just(flights)
                default:
                    fatalError("Error")
                }
            })
    }
    
    private let baseUrl = "https://app.goflightlabs.com/"
    private let apiKey = ""
    
}
