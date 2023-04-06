//
//  WeatherViewModel.swift
//  MvvMwithStoryboard
//
//  Created by Hilal Öztemel on 22.03.2023.
//

import Foundation

class WeatherViewModel{
    
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
    
    func formatTemperature(_ temperature: Double) -> String {
        let temperatureFormatter = MeasurementFormatter()
        temperatureFormatter.numberFormatter.maximumFractionDigits = 0
        temperatureFormatter.unitOptions = .temperatureWithoutUnit
        let formattedTemperature = temperatureFormatter.string(from: Measurement(value: temperature, unit: UnitTemperature.celsius))
        return formattedTemperature
    }
    
    func getWeather(apikey: String,lat : Double,lon: Double, completion: @escaping (Result<WeatherData?, Error>) -> Void) {
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

