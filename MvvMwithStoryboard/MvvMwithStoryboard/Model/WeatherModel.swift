//
//  model.swift
//  KonumVerisiAlma
//
//  Created by Hilal Öztemel on 23.03.2023.
//

import Foundation

// MARK: - Weather
struct WeatherData: Codable {
    
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
