//
//  model.swift
//  KonumVerisiAlma
//
//  Created by Hilal Öztemel on 23.03.2023.
//

import Foundation

// MARK: - Weather
struct WeatherData: Codable , Equatable {
    static func == (lhs: WeatherData, rhs: WeatherData) -> Bool {
        return true
    }
    
    
    let timezone: String
    let current: Current
    let daily: [Daily]

    enum CodingKeys: String, CodingKey {
        case timezone
        case current, daily
    }
}

// MARK: - Current
struct Current: Codable {
    
    let temp: Double
    let weather: [WeatherElement]

    enum CodingKeys: String, CodingKey {
        case temp
        case weather
    }
}
// MARK: - Daily
struct Daily: Codable {
    let dt: Int
    let temp: Temp
    let weather: [WeatherElement]
    
    enum CodingKeys: String, CodingKey {
        case dt
        case temp
        case weather
    }
}

// MARK: - WeatherElement
struct WeatherElement: Codable {
    let icon: String
    
}


// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
}

enum APIError: Error {
    case invalidData
}

extension WeatherElement {
    var iconUrl: URL? {
        return URL(string: "https://openweathermap.org/img/w/\(icon).png")
    }
}

struct WeatherTableViewModel{
    let weatherList : [Daily]
    
    func numberOfRowsInSection() -> Int {
        return self.weatherList.count
    }
    func weatherAtIndexPath(_ index: Int) -> DailyWeatherViewModel {
        let weather = self.weatherList[index]
        return DailyWeatherViewModel(weather: weather)
    }
}
struct DailyWeatherViewModel{
    let weather : Daily
    
    var day : Int {
        return self.weather.dt
    }
    var icon : URL? {
        return self.weather.weather[0].iconUrl
    }
    var temp1 : Double {
        return self.weather.temp.max
    }
    var temp2 : Double {
        return self.weather.temp.min
    }
}
