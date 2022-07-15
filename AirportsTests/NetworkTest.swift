//
//  NetworkTest.swift
//  AirportsTests
//
//  Created by Dawid Karpiński on 07/07/2022.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking

@testable import Airports

class NetworkTest: XCTestCase {
    
    private var networkManager: NetworkManager!
    private var flightlabsService: FlighLabsService!
    private var disposeBag = DisposeBag()
    
    override func setUp() {
        networkManager = NetworkManager()
        flightlabsService = FlighLabsService()
    }
    
    func testGetCity() {

        XCTAssertNotNil(try? flightlabsService.getCity("berlin").toBlocking().first())
    }
    
    func testGetCityIsNill() {

        XCTAssertNil(try? flightlabsService.getCity("berl2in").toBlocking().first())
    }
}
