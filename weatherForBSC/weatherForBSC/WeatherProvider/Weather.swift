import Foundation

struct Weather {
    let temprature: Double
    let desription: String
    
    init(owm: OWMWeather) {
        temprature = owm.main.temp
        desription = owm.weather.first?.description ?? ""
    }
}
