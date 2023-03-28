//
//  WeatherViewModel.swift
//  MvvMwithStoryboard
//
//  Created by Hilal Öztemel on 22.03.2023.
//

import Foundation

class WeatherViewModel{
    
    func getWeather(apikey: String,lat : Double,lon: Double, completion: @escaping (Result<WeatherData?, Error>) -> Void) {
//        let city = "istanbul"
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely,hourly&appid=\(apikey)&units=metric") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error.localizedDescription as! Error))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherData.self, from: data)
                print(weatherData)
                

                completion(.success(weatherData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
  
}

