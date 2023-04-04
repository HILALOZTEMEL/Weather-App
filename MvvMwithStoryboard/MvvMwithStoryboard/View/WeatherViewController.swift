//
//  secondViewController.swift
//  MvvMwithStoryboard
//
//  Created by Hilal Öztemel on 21.03.2023.
//

import UIKit
import CoreLocation


class WeatherViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var cityTextField: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    
    public var apiKeyData: String = "-"
    var locationManager = CLLocationManager()
    var latValue : Double = 0.0
    var lonValue : Double = 0.0
    private var tableViewModel : WeatherTableViewModel!
    private var formattedData = FormattedData()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Weather App"
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        print("controller : ",apiKeyData)
   
   
           
        tableView?.delegate = self
        tableView?.dataSource = self
        
        
      
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewModel == nil ? 0 : self.tableViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeatherCell
        let weatherViewModel = self.tableViewModel.weatherAtIndexPath(indexPath.row)
        let formatedday = formattedData.formatDate(weatherViewModel.day)
        
        cell.DayLabel.text = String(formatedday)
        if let iconUrl = weatherViewModel.icon{
            let task = URLSession.shared.dataTask(with: iconUrl) { data, response, error in
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.IconImageView.image = image
                    }
                }
            }
            task.resume()
        }
        let formatTemp1 = formattedData.formatTemperature(weatherViewModel.temp1)
        let formatTemp2 = formattedData.formatTemperature(weatherViewModel.temp2)
        cell.Temp1Label.text = String(formatTemp1) + "C"
        cell.Temp2Label.text = String(formatTemp2) + "C"
        return cell
        
        
    }


    
  
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations[0].coordinate.latitude)
        print(locations[0].coordinate.longitude)
        self.latValue = locations[0].coordinate.latitude
        self.lonValue = locations[0].coordinate.longitude
        
        getWeather()
    }

    func getWeather() {
    
        
        print(apiKeyData)
        Service().getWeather(apikey: apiKeyData,lat: latValue,lon: lonValue) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherData):
                    print(weatherData)
                    self.cityTextField.text = weatherData?.timezone
                    let formatTemp = self.formattedData.formatTemperature(weatherData?.current.temp ?? 0)
                    self.temperatureLabel.text = "\(formatTemp)C"
                    
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
                    self.tableViewModel = WeatherTableViewModel(weatherList: weatherData!.daily )
                    self.tableView!.reloadData()
                    
                case .failure(let error):
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true)
                }
            }
        }
    }


}
