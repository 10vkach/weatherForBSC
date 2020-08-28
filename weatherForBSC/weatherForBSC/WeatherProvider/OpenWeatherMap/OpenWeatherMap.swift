import Foundation

class OpenWeatherMap: WeatherProvider {
    
    weak var delegate: WeatherProviderDelegate?    
    
    private let requestCreator = OpenWeatherMapRequestCreator()
    
    func currentWeather(inCity: String) {
        let session = URLSession(configuration: .default)
        let url = OpenWeatherMapRequestCreator().weather(cityName: inCity)
        session.dataTask(with: url) { (data, response, error) in
            if let dataSafe = data {
                guard let owmWeather = try? JSONDecoder().decode(OWMWeather.self, from: dataSafe) else {
                    self.delegate?.currentWeatherLoadingError(error: nil, description: "Ошибка при попытке парса JSON")
                    return
                }                
                self.delegate?.currentWeatherLoaded(forCity: inCity, weather: Weather(owm: owmWeather))
            }
            if let errorSafe = error {
                self.delegate?.currentWeatherLoadingError(error: errorSafe, description: "Ошибка при загрузке погоды")
            }
        }.resume()
        
        return
    }
    
}
