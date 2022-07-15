//
//  NetworkManager.swift
//  Airports
//
//  Created by Dawid Karpiński on 07/07/2022.
//

import RxSwift

open class NetworkManager: Networking {
    
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func getData(_ url: URL) -> Observable<Result<Data, NetworkError>> {
        let request = URLRequest.init(url: url)
        return session.rx
            .response(request: request)
            .flatMapLatest { (response: HTTPURLResponse, data: Data) -> Observable<Result<Data, NetworkError>> in
                
                var result: Result<Data, NetworkError>
                if response.statusCode == 200 {
                    result = .success(data)
                } else {
                    result = .failure(.errorConnection)
                }
                
                return Observable.just(result)
            }
    }
}
