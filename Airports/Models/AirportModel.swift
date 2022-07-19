//
//  AirportModel.swift
//  Airports
//
//  Created by Dawid Karpiński on 18/07/2022.
//

import ObjectMapper

struct AirportModel: Mappable {
    init() {}
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        self.id <- map["id"]
        self.iataCode <- map["iata_code"]
        self.icaoCode <- map["icao_code"]
        self.countryIso2 <- map["country_iso2"]
        self.latitude <- map["latitude"]
        self.longitude <- map["longitude"]
        self.airportName <- map["airport_name"]
        self.countryName <- map["country_name"]
        self.phoneNumber <- map["phone_number"]
        self.timezone <- map["timezone"]
    }
    
    var id: String?
    var iataCode: String?
    var icaoCode: String?
    var countryIso2: String?
    var latitude: String?
    var longitude: String?
    var airportName: String?
    var countryName: String?
    var phoneNumber: String?
    var timezone: String?
    
}
