import Foundation

struct OWMWeather: Decodable {
    let weather: [WeatherItem]
    let main: Main
    
    struct WeatherItem: Decodable {
        let main: String
    }
        
    struct Main: Decodable {
        let temp: Double
    }
}
