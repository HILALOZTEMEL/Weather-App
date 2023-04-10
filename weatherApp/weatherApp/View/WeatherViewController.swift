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
    public var latValue: Double = 0.0
    public var lonValue: Double = 0.0
    private var tableViewModel : WeatherTableViewModel!
    private var formattedData = WeatherViewModel()
    var cityName: String = ""
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Weather App"
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        print("controller_api : ",apiKeyData)
        print("controller_lat : ",latValue)
        print("controller_lon : ",lonValue)
        tableView?.delegate = self
        tableView?.dataSource = self
        
    }
    
    @IBAction func ButtonKonumSec(_ sender: Any) {
        print("button cliked")
        performSegue(withIdentifier: "toMapVC", sender: nil)
    }
    
        
        
   
    func iconView(iconURL:URL?,completion: @escaping (UIImage?) -> Void){
        if let iconUrl = iconURL{
            let task = URLSession.shared.dataTask(with: iconUrl) { data, response, error in
                if let data = data {
                    let image = UIImage(data: data)
                    completion(image)
                     } else {
                         completion(nil)
                     }
                 }
                 task.resume()
             } else {
                 completion(nil)
             }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewModel == nil ? 0 : self.tableViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeatherCell
        let weatherViewModel = self.tableViewModel.weatherAtIndexPath(indexPath.row)
        
        let formatedday = formattedData.formatDate(weatherViewModel.day)
        let formatTemp1 = formattedData.formatTemperature(weatherViewModel.temp1)
        let formatTemp2 = formattedData.formatTemperature(weatherViewModel.temp2)
        
        iconView(iconURL: weatherViewModel.icon) { image in
            DispatchQueue.main.async {
                cell.IconImageView.image = image
            }
        }
        cell.DayLabel.text = String(formatedday)
        cell.Temp1Label.text = String(formatTemp1) + "C"
        cell.Temp2Label.text = String(formatTemp2) + "C"
        return cell
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if latValue == 0.0 , lonValue == 0.0 {
            self.latValue = locations[0].coordinate.latitude
            self.lonValue = locations[0].coordinate.longitude
        }
        print(latValue)
        print(lonValue)

        getCityNameFromLocation(latitude: latValue, longitude: lonValue) { cityName in
            if let cityName = cityName {
                print("City: \(cityName)")
                self.cityName = cityName
            } else {
                print("Unable to determine city.")
            }
        }

        
        getWeather()
    }


    func getWeather() {
        
        WeatherViewModel().getWeather(apikey: apiKeyData,lat: latValue,lon: lonValue) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherData):
                    print(weatherData)
                    let formatTemp = self.formattedData.formatTemperature(weatherData?.current.temp ?? 0)
                    
                    self.cityTextField.text = self.cityName
                    self.temperatureLabel.text = "\(formatTemp)C"
                    self.iconView(iconURL: weatherData?.current.weather[0].iconUrl) { image in
                        DispatchQueue.main.async {
                            self.iconImageView.image = image
                          }
                    }
                    self.tableViewModel = WeatherTableViewModel(weatherList: weatherData!.daily )
                    self.tableView!.reloadData()
                    
                case .failure(let error):
                    let alert = UIAlertController(title: "Error", message: "API Key may be missing or incorrect", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true)
                }
            }
        }
    }

    func getCityNameFromLocation(latitude: Double, longitude: Double, completion: @escaping (String?) -> ()) {
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard error == nil, let placemark = placemarks?.first else {
                completion(nil)
                return
            }
            
            completion(placemark.locality)
        }
    }
}
