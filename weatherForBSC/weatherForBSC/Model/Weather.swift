import Foundation

struct Weather {
    let city: String
    let cityID: Int
    let tempratureCelsius: Double
    let description: String
    
    init(owm: OWMWeather) {
        self.city = owm.name
        cityID = owm.id
        tempratureCelsius = owm.main.temp
        description = owm.weather.first?.description ?? ""
    }
    
    init(city: String) {
        self.city = city
        cityID = 0
        tempratureCelsius = 0
        description = "Не определена"
    }
    
    func temprature(inUnits units: TempratureUnits) -> String {
        switch units {
        case .celsius:
            return String(format: "%.0f", tempratureCelsius) + "°"
        case .farenheit:
            let f = 1.8 * tempratureCelsius + 32
            return String(format: "%.0f", f) + "°"
//        case .kelvin:
//            let k = tempratureCelsius - 273.15
//            return String(format: "%.0f", k) + "°"
        }
    }
}

enum TempratureUnits: String, CaseIterable {
    case celsius = "°C"
    case farenheit = "°F"
//    case kelvin = "°K"
}
