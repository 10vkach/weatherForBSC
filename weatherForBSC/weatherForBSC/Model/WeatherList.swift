import Foundation

class WeatherList {
    var places: [Weather] = []
    var tempratureUnits: TempratureUnits = .celsius
    let weatherNetworker = WeatherNetworker(provider: OpenWeatherMap())
    
    init(citys: [String], units: TempratureUnits) {
        citys.forEach({ self.places.append(Weather(city: $0)) })
        tempratureUnits = units
    }
    
    func updateAllWeather() {
        places.forEach({
            weatherNetworker.currentWeather(inCity: $0.city)
        })
    }
}

