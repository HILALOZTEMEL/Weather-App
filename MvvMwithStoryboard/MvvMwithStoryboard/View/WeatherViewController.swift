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
    private var tableViewModel : WeatherTableViewModel!
    
    
    
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
   
    func formatDate(_ timestamp: Int) -> String {
        // Zamandan NSDate objesi çıkart
        let date = NSDate(timeIntervalSince1970: TimeInterval(timestamp))

        // Tarihi istediğiniz formatta yazdırın
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.dateFormat = "EEEE" // Örnek çıktı: "Perşembe, 29 Mart 2023"
        let formattedDate = formatter.string(from: date as Date)

        return formattedDate
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewModel == nil ? 0 : self.tableViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeatherCell
        let weatherViewModel = self.tableViewModel.weatherAtIndexPath(indexPath.row)
        let formatedday = formatDate(weatherViewModel.day)
        
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
        
        cell.Temp1Label.text = String(weatherViewModel.temp1) + "°C"
        cell.Temp2Label.text = String(weatherViewModel.temp2) + "°C"
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
                    self.temperatureLabel.text = "\(weatherData?.current.temp ?? 0)°C"
                    
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
                    self.tableView.reloadData()
                    
                case .failure(let error):
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true)
                }
            }
        }
    }


}
