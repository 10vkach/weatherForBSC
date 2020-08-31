import Foundation
import UIKit

class WeatherView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var labelCityName: UILabel!
    @IBOutlet weak var labelWeatherDescription: UILabel!
    @IBOutlet weak var labelTempreture: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    init(frame: CGRect, weather: Weather, inUnits units: TempratureUnits) {
        super.init(frame: frame)
        commonInit()
        setWeather(weather: weather)
        labelTempreture.text = weather.temprature(inUnits: units)
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("WeatherView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    private func setWeather(weather: Weather) {
        labelCityName.text = weather.city
        labelWeatherDescription.text = weather.description
    }
}
