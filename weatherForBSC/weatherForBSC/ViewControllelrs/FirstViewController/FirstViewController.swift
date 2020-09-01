import UIKit

class FirstViewController: UIViewController, WeatherNetworkerDelegate, UIScrollViewDelegate, UIAdaptivePresentationControllerDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let model = WeatherList(citys: ["ижевскижевскижевскижевск", "Москва", "Нижний Новгород"], units: .celsius)
    
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
    }

    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        setScrollViewContent()
    }
    
//MARK: Actions
    @IBAction func configButtonTouch(_ sender: Any) {
        guard let configViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(identifier: "ConfigViewControllerID")
            as? ConfigViewController else {
                print("Ошибка при создании ConfigViewController")
                return
        }
        configViewController.model = model        
        configViewController.presentationController?.delegate = self
        present(configViewController, animated: true)
    }
    
//MARK: WeatherProviderDelegate
    func currentWeatherLoaded(weather: Weather) {
        print(weather.tempratureCelsius)
        print(weather.description)
        print(weather.city)
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
        scrollView.subviews.forEach({ $0.removeFromSuperview() })
        
        if model.places.isEmpty {
            setScrollViewContentNoCitys()
            return
        }
        scrollView.contentSize = CGSize(width: scrollView.bounds.width * CGFloat(model.places.count),
                                        height: scrollView.bounds.height)
        
        for i in 0..<model.places.count {
            let weatherViewFrame = CGRect(x: scrollView.bounds.width * CGFloat(i),
                                          y: 0,
                                          width: scrollView.bounds.width,
                                          height: scrollView.bounds.height)
            let weatherView = WeatherView(frame: weatherViewFrame,
                                          weather: model.places[i],
                                          inUnits: model.tempratureUnits)
            
            scrollView.addSubview(weatherView)
        }
        pageControl.numberOfPages = model.places.count
    }
    
    private func setScrollViewContentNoCitys() {
        let noCitysFrame = CGRect(x: 0,
                                  y: 0,
                                  width: scrollView.bounds.width,
                                  height: scrollView.bounds.height)
        scrollView.addSubview(NoCityView(frame: noCitysFrame))
        scrollView.contentSize = noCitysFrame.size
        pageControl.numberOfPages = 1
    }
    
}

