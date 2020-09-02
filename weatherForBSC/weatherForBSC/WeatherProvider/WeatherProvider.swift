import Foundation

protocol WeatherProvider {
    func currentWeatherURL(forCity: String) -> URL
    func parseCurrentWeather(data: Data) -> Weather?
}
