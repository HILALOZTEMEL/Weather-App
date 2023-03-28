//
//  secondViewController.swift
//  MvvMwithStoryboard
//
//  Created by Hilal Öztemel on 21.03.2023.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource{

    
    @IBOutlet weak var cityTextField: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    
    var apiKeyData = "-"
    var locationManager = CLLocationManager()
    var latValue : Double = 0.0
    var lonValue : Double = 0.0
    private let viewModel = WeatherViewModel()
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Weather App"
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "test"
        return cell
    }
    
  
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations[0].coordinate.latitude)
        print(locations[0].coordinate.longitude)
        self.latValue = locations[0].coordinate.latitude
        self.lonValue = locations[0].coordinate.longitude
        getWeather()
    }
//    func dateFormater(unixTimestamp :Int){
//        let date = Date(timeIntervalSince1970: unixtimeInterval)
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
//        dateFormatter.locale = NSLocale.current
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" //Specify your format that you want
//        let strDate = dateFormatter.string(from: date)
//    }

    func getWeather() {
    
        //guard let apiKey = apiKeyData else { return } // guard let : true yada false döner
        print(apiKeyData)
        viewModel.getWeather(apikey: apiKeyData,lat: latValue,lon: lonValue) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherData):
                    print(weatherData)
                    self.cityTextField.text = weatherData?.timezone
                    self.temperatureLabel.text = "\(weatherData?.current.temp ?? 0)°C"
                    //self.descriptionLabel.text = "Description: \(weather.description)"
                    if let iconUrl = weatherData?.current.weather[0].iconUrl {
                                        let task = URLSession.shared.dataTask(with: iconUrl) { data, response, error in
                                            if let data = data {
                                                let image = UIImage(data: data)
                                                DispatchQueue.main.async {
                                                    self.iconImageView.image = image
                                                }
                                            }
                                        }
                                        task.resume()
                                    }
                    
                case .failure(let error):
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true)
                }
            }
        }
    }


}
