import Foundation

struct Weather {
    let city: String
    let tempratureCelsius: Double
    let description: String
    
    init(forCity city: String, owm: OWMWeather) {
        self.city = city
        tempratureCelsius = owm.main.temp
        description = owm.weather.first?.description ?? ""
    }
    
    init(city: String) {
        self.city = city
        tempratureCelsius = 0
        description = "Не определена"
    }
    
    func temprature(inUnits units: TempratureUnits) -> String {
        switch units {
        case .celsius:
            return "\(tempratureCelsius)°C"
        case .farenheit:
            return "451°F"
        }
    }
}
