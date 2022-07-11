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
        city_id <- map["city_id"]
        iata_code <- map["iata_code"]
        country_iso2 <- map["country_iso2"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        city_name <- map["city_name"]
        timezone <- map["timezone"]
    }
    
    
    var city_id: Int!
    var iata_code: String?
    var country_iso2: String?
    var latitude: Float!
    var longitude: Float!
    var city_name: String?
    var timezone: String?
    
}
