import Foundation

class WeatherNetworker {
    
    weak var delegate: WeatherNetworkerDelegate?
    let weatherProvider: WeatherProvider
    
    init(provider: WeatherProvider) {
        weatherProvider = provider
    }
    
    func currentWeather(inCity city: String) {
        let session = URLSession(configuration: .default)
        let url = weatherProvider.currentWeatherURL(forCity: city)
        session.dataTask(with: url) { (data, response, error) in
            if let dataSafe = data {
                guard let owmWeather = try? JSONDecoder().decode(OWMWeather.self, from: dataSafe) else {
                    self.delegate?.currentWeatherLoadingError(error: nil, description: "Ошибка при попытке парса JSON")
                    return
                }
                self.delegate?.currentWeatherLoaded(weather: Weather(forCity: city, owm: owmWeather))
            }
            if let errorSafe = error {
                self.delegate?.currentWeatherLoadingError(error: errorSafe, description: "Ошибка при загрузке погоды")
            }
        }.resume()
        
        return
    }
}
