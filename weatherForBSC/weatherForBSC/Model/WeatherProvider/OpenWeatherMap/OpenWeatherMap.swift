import Foundation

class OpenWeatherMap: WeatherProvider {
    
    func currentWeatherURL(forCity city: String) -> URL {
        return OpenWeatherMapRequestCreator().weather(cityName: city)
    }
    
    func parseCurrentWeather(data: Data) -> Weather? {
        guard let owmWeather = try? JSONDecoder().decode(OWMWeather.self, from: data) else {
            return nil
        }
        return Weather(owm: owmWeather)
    }
    
    func groupWeatherURL(forCityIDs cityIDs: [Int]) -> URL {
        return OpenWeatherMapRequestCreator().group(cityIDs: cityIDs)
    }
    
    func parseGroupWeather(data: Data) -> [Weather] {
        return []
    }
    
}
