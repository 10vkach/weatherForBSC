import Foundation

protocol WeatherProviderDelegate: class {
    func currentWeatherLoaded(forCity city: String, weather: Weather)
    func currentWeatherLoadingError(error: Error?, description: String)
}
