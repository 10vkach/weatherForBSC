import Foundation

struct OWMWeather: Decodable {
    let weather: [WeatherItem]
    let main: Main
    let name: String
    
    struct WeatherItem: Decodable {
        let description: String
    }
        
    struct Main: Decodable {
        let temp: Double
    }
}
