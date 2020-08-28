import UIKit

class ViewController: UIViewController, WeatherProviderDelegate {
    
//MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let weatherProvider = OpenWeatherMap()
        weatherProvider.delegate = self
        weatherProvider.currentWeather(inCity: "лондон")
    }

//MARK: WeatherProviderDelegate
    func currentWeatherLoaded(forCity city: String, weather: Weather) {
        print(weather.temprature)
        print(weather.desription)
        print(city)
    }
    
    func currentWeatherLoadingError(error: Error?, description: String) {
        print("error -> ", error ?? "nil")
        print("description -> ", description)
    }
    

}

