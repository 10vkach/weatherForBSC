import Foundation

class OpenWeatherMap: WeatherProvider {
    
    private let requestCreator = OpenWeatherMapRequestCreator()
    
    func currentWeatherURL(forCity city: String) -> URL {
        return OpenWeatherMapRequestCreator().weather(cityName: city)
    }    
    
}
