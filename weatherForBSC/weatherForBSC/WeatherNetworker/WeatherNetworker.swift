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
                    DispatchQueue.main.async {
                        self.delegate?.currentWeatherLoadingError(error: nil, description: "Ошибка при попытке парса JSON")
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.delegate?.currentWeatherLoaded(weather: Weather(forCity: city, owm: owmWeather))
                }
            }
            if let errorSafe = error {
                DispatchQueue.main.async {
                    self.delegate?.currentWeatherLoadingError(error: errorSafe, description: "Ошибка при загрузке погоды")
                }
            }
        }.resume()
        
        return
    }
}
