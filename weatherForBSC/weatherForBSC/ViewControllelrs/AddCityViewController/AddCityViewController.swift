import Foundation
import UIKit

class AddCityViewController: UIViewController, WeatherNetworkerDelegate {
    
    @IBOutlet weak var textFieldCity: UITextField!
    var model: WeatherList?
    
//MARK: Actions
    @IBAction func buttonCancelTouch(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func buttonOKTouch(_ sender: Any) {
        guard let newCityName = textFieldCity.text else { return }
        
        let weatherNetworker = WeatherNetworker(provider: OpenWeatherMap())
        weatherNetworker.delegate = self
        weatherNetworker.currentWeather(inCity: newCityName)
    }
    
//MARK: WeatherNetworkerDelegate
    func currentWeatherLoaded(weather: Weather) {
        model?.places.append(weather)
        alertSuccessAdded(city: weather.city)
    }
    
    func currentWeatherLoadingError(error: Error?, description: String) {
        alertCityAddError()
    }
    
//MARK: Private
    private func alertCityAddError() {
        let alertError = UIAlertController(title: "Ошибка",
                                           message: "Такой город не найден",
                                           preferredStyle: .alert)
        present(alertError, animated: true)
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when){
          alertError.dismiss(animated: true, completion: nil)
        }
    }
    
    private func alertSuccessAdded(city: String) {
        let alertError = UIAlertController(title: city,
                                           message: "Этот город добавлен в список городов",
                                           preferredStyle: .alert)
        present(alertError, animated: true)
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when){
          alertError.dismiss(animated: true, completion: nil)
        }
    }
    
    deinit {
        print("deinit -> AddCityViewController")
    }
}
