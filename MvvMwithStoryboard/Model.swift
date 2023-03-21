//
//  Model.swift
//  MvvMwithStoryboard
//
//  Created by Hilal Öztemel on 21.03.2023.
//  Burada değişkenler tanımlanır

import Foundation

struct WeatherModel : Codable{
    let timezone : String
    let current : CurrentWeather
}

struct CurrentWeather: Codable {
    let temp : Float
    let weather: [WeatherInfo]
}

struct WeatherInfo: Codable {
    let main : String
    let description : String
}
