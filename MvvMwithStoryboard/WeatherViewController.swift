//
//  secondViewController.swift
//  MvvMwithStoryboard
//
//  Created by Hilal Öztemel on 21.03.2023.
//

import UIKit

class WeatherViewController: UIViewController {

    
    @IBOutlet weak var cityTextField: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    
    var apiKeyData = "-"
    
    private let viewModel = WeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Weather App"
        getWeather()
    }

    func getWeather() {
    
        //guard let apiKey = apiKeyData else { return } // guard let : true yada false döner
        print(apiKeyData)
        viewModel.getWeather(apikey: apiKeyData) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    self.cityTextField.text = "istanbul"
                    self.temperatureLabel.text = "\(weather.temperature)°C"
                    //self.descriptionLabel.text = "Description: \(weather.description)"
                    if let iconUrl = weather.iconUrl {
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
