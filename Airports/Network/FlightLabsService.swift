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
    
    func getCity(_ searchValue: String) -> Observable<[CityModel]>{
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
    private let apiKey = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI0IiwianRpIjoiMGM2NTZiZTYzNjlkNDI3ZjNhYWYwZmM0N2IyOGZiMTRhNzVkNzU4NDc5NzI5NDc3ZGE1NTY0Y2NmMGFhMTE4Zjc0MGJiMmI0NTljNDdlZDkiLCJpYXQiOjE2NTcwOTk1NDYsIm5iZiI6MTY1NzA5OTU0NiwiZXhwIjoxNjg4NjM1NTQ2LCJzdWIiOiI3OTM0Iiwic2NvcGVzIjpbXX0.GXiqM87AXzXv0NVRqwSSuD2MO5EsaXDtn9IXD_JkW751CF7hPk8uyuP5QOGBrqXf8zh63dEGjREIWYt7L5wqYw"
    
}
