import Foundation

protocol WeatherProvider {
    func currentWeatherURL(forCity: String) -> URL
    func parseCurrentWeather(data: Data) -> Weather?
        
    func groupWeatherURL(forCityIDs: [Int]) -> URL
    func parseGroupWeather(data: Data) -> [Weather]
}
