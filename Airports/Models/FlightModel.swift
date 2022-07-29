//
//  FlightModel.swift
//  Airports
//
//  Created by Dawid Karpiński on 20/07/2022.
//

import ObjectMapper

struct FlightModel: Mappable {
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        self.flightStatus <- map["flight_status"]
        self.arrival <- map["arrival"]
        self.departure <- map["departure"]
    }
    
    var flightStatus: String?
    var departure: FlightDetailsModel?
    var arrival: FlightDetailsModel?

}

struct FlightDetailsModel: Mappable {
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        self.airport <- map["airport"]
        self.scheduled = convertStringToDate(map["scheduled"].currentValue as! String)
    }
    
    var airport: String?
    var scheduled: Date?

    /// Date -> String
    func getDataAsString() -> String {
        return transformDateToString(scheduled!)
    }
    
    /// Parsing json value to date
    private func convertStringToDate(_ source: String) -> Date {
        let dateFormatterr = DateFormatter()
        dateFormatterr.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatterr.date(from: source)!
    }
    
    /// Formatterr date to string DD.MM.YYY HH:MM
    private func transformDateToString(_ source: Date) -> String {
        let dateFormatterr = DateFormatter()
        dateFormatterr.dateFormat = "dd.MM.YY hh:mm"
        return dateFormatterr.string(from: source)
    }
    
}
