import Foundation

protocol WeatherProvider {
    func currentWeatherURL(forCity: String) -> URL
}
