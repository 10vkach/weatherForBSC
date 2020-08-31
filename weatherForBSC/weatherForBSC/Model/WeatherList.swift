import Foundation

class WeatherList {
    var places: [Weather] = []
    var tempratureUnits: TempratureUnits = .celsius
    
    init(citys: [String], units: TempratureUnits) {
        citys.forEach({ self.places.append(Weather(city: $0)) })
        tempratureUnits = units
    }
}


enum TempratureUnits {
    case celsius
    case farenheit
}
