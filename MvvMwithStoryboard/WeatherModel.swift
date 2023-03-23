//
//  WeatherModel.swift
//  MvvMwithStoryboard
//
//  Created by Hilal Öztemel on 22.03.2023.
//

import Foundation

struct WeatherData: Codable {
    let main: Main
    let weather: [WeatherInfo]
    
    enum CodingKeys: String, CodingKey {
        case main
        case weather
    }
}

struct Main: Codable {
    let temperature: Double
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
    }
}

struct WeatherInfo: Codable {
    let description: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case description
        case icon = "icon"
    }
}

struct Weather {
    let temperature: Double
    let description: String
    let iconUrl: URL?
}

enum APIError: Error {
    case invalidData
}

extension WeatherInfo {
    var iconUrl: URL? {
        return URL(string: "https://openweathermap.org/img/w/\(icon).png")
    }
}
