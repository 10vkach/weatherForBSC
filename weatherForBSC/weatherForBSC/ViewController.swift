import UIKit

class ViewController: UIViewController, WeatherNetworkerDelegate {
    
//MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let weatherNetworker = WeatherNetworker(provider: OpenWeatherMap())
        weatherNetworker.delegate = self
        weatherNetworker.currentWeather(inCity: "ижевск")
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

