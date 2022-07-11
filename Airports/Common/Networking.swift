//
//  Networking.swift
//  Airports
//
//  Created by Dawid Karpiński on 07/07/2022.
//

import RxSwift

enum NetworkError: Error {
    case errorConnection
}

protocol Networking {
    func getData(_ url: URL) -> Observable<Result<Data, NetworkError>>
}
