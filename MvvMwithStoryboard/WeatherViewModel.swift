//
//  WeatherViewModel.swift
//  MvvMwithStoryboard
//
//  Created by Hilal Öztemel on 22.03.2023.
//

import Foundation

struct WeatherViewModel {
    
    func getWeather(apikey: String, completion: @escaping (Result<Weather, Error>) -> Void) {
        let city = "istanbul"
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apikey)&units=metric")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherData.self, from: data)
                let weather = weatherData.weather.first
                let temperature = weatherData.main.temperature
                let description = weather?.description ?? ""
                
                let iconUrl = weather?.iconUrl
                let weatherObject = Weather(temperature: temperature, description: description, iconUrl: iconUrl)
                                completion(.success(weatherObject))
                completion(.success(weatherObject))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

