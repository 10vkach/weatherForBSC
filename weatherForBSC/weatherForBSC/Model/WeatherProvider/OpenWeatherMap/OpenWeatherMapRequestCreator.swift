import Foundation

class OpenWeatherMapRequestCreator {
    
    func weather(cityName: String) -> URL {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.host
        components.path = Constants.Paths.weather
        components.queryItems = [
            URLQueryItem(name: Constants.WeatherQueryItemNames.cityName,
                         value: cityName),
            URLQueryItem(name: Constants.WeatherQueryItemNames.appID,
                         value: Constants.Params.appID),
            URLQueryItem(name: Constants.WeatherQueryItemNames.lang,
                         value: Constants.Params.language),
            URLQueryItem(name: Constants.WeatherQueryItemNames.units,
                         value: Constants.Params.units)
        ]
        guard let url = components.url else {
            print("Ошибка при формировании URL")
            fatalError()
        }
        return url
    }
    
    func group(cityIDs: [Int]) -> URL {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.host
        components.path = Constants.Paths.group
        let joinedArray = cityIDs
            .map({ "\($0)" })
            .joined(separator: ",")
        components.queryItems = [
            URLQueryItem(name: Constants.WeatherQueryItemNames.groupName,
                         value: joinedArray),
            URLQueryItem(name: Constants.WeatherQueryItemNames.appID,
                         value: Constants.Params.appID),
            URLQueryItem(name: Constants.WeatherQueryItemNames.lang,
                         value: Constants.Params.language),
            URLQueryItem(name: Constants.WeatherQueryItemNames.units,
                         value: Constants.Params.units)
        ]
        guard let url = components.url else {
            print("Ошибка при формировании group URL")
            fatalError()
        }
        print(url)
        return url
    }
}

fileprivate struct Constants {
    static let scheme = "https"
    static let host = "api.openweathermap.org"
    
    struct Paths {
        static let weather = "/data/2.5/weather"
        static let group = "/data/2.5/group"
    }
    
    struct WeatherQueryItemNames {
        static let cityName = "q"
        static let appID = "appid"
        static let lang = "lang"
        static let units = "units"
        static let groupName = "id"
    }
    
    struct Params {
        static let appID = "68f6ee55f12aa56ef0c8b31f94cf26c0"
        static let language = "ru"
        static let units = "metric"
    }
}
