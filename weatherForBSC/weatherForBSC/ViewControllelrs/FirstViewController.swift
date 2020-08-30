import UIKit

class FirstViewController: UIViewController, WeatherNetworkerDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var citys: [String] = ["ижевск", "Москва", "лондон"]
    
//MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.layer.borderColor = CGColor(genericGrayGamma2_2Gray: 0.5, alpha: 1)
        scrollView.layer.borderWidth = 1
        
        let weatherNetworker = WeatherNetworker(provider: OpenWeatherMap())
        weatherNetworker.delegate = self
        weatherNetworker.currentWeather(inCity: "ижевск")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setScrollViewContent()
        pageControl.numberOfPages = citys.count
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
    
//MARK: ScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = round(scrollView.contentOffset.x / scrollView.bounds.width)
        pageControl.currentPage = Int(page)
    }
    	
//MARK: Private
    private func setScrollViewContent() {
        if citys.isEmpty {
            setScrollViewContentNoCitys()
            return
        }
        scrollView.contentSize = CGSize(width: scrollView.bounds.width * CGFloat(citys.count),
                                        height: scrollView.bounds.height)
        
        for i in 0..<citys.count {
            let weatherViewFrame = CGRect(x: scrollView.bounds.width * CGFloat(i),
                                          y: 0,
                                          width: scrollView.bounds.width,
                                          height: scrollView.bounds.height)
            scrollView.addSubview(WeatherView(frame: weatherViewFrame))
        }
    }
    
    private func setScrollViewContentNoCitys() {
        scrollView.addSubview(NoCityView(frame: scrollView.bounds))
        scrollView.contentSize = CGSize(width: scrollView.bounds.width,
                                        height: scrollView.bounds.height)
    }
    
}

