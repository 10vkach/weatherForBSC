import Foundation
import UIKit

class CityTableViewCell: UITableViewCell {
    static let reuseID = "CityTableViewCell"
    
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var labelTemprature: UILabel!
    
    func setUI(with weather: Weather, tempretureUnits units: TempratureUnits) {
        labelCity.text = weather.city
        labelTemprature.text = weather.temprature(inUnits: units)
        contentView.layer.borderColor = CGColor(genericGrayGamma2_2Gray: 0.5, alpha: 1)
        contentView.layer.borderWidth = 1
    }
}
