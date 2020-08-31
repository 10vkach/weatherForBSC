import Foundation

protocol WeatherNetworkerDelegate: class {
    func currentWeatherLoaded(weather: Weather)
    func currentWeatherLoadingError(error: Error?, description: String)
}
