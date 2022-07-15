//
//  CityModel.swift
//  Airports
//
//  Created by Dawid Karpiński on 07/07/2022.
//

import ObjectMapper

struct CityModel: Mappable {
    init?(map: Map) { }    
    
    mutating func mapping(map: Map) {
        cityId <- map["city_id"]
        iataCode <- map["iata_code"]
        countryIso2 <- map["country_iso2"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        cityName <- map["city_name"]
        timezone <- map["timezone"]
    }
    
    var cityId: Int!
    var iataCode: String?
    var countryIso2: String?
    var latitude: Float!
    var longitude: Float!
    var cityName: String?
    var timezone: String?
    
}
