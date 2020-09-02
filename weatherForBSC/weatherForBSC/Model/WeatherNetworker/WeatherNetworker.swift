import Foundation

class WeatherNetworker {
    
    weak var delegate: WeatherNetworkerDelegate?
    private let weatherProvider: WeatherProvider
    
    init(provider: WeatherProvider) {
        weatherProvider = provider
    }
    
    func currentWeather(inCity city: String) {
        let session = URLSession(configuration: .default)
        let url = weatherProvider.currentWeatherURL(forCity: city)
        session.dataTask(with: url) { (data, response, error) in
            if let dataSafe = data {
                guard let weather = self.weatherProvider.parseCurrentWeather(data: dataSafe) else {
                    DispatchQueue.main.async {
                        self.delegate?.currentWeatherLoadingError(error: nil, description: "Ошибка при попытке парса JSON")
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.delegate?.currentWeatherLoaded(weather: weather)
                }
            }
            if let errorSafe = error {
                DispatchQueue.main.async {
                    self.delegate?.currentWeatherLoadingError(error: errorSafe, description: "Ошибка при загрузке погоды")
                }
            }
        }.resume()
    }
}
