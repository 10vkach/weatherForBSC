import Foundation

protocol WeatherNetworkerDelegate: class {
    func currentWeatherLoaded(forCity city: String, weather: Weather)
    func currentWeatherLoadingError(error: Error?, description: String)
}
