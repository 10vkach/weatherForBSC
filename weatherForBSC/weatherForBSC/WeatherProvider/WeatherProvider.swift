import Foundation

protocol WeatherProvider {
    var delegate: WeatherProviderDelegate? { get set }
    func currentWeather(inCity: String)
}
