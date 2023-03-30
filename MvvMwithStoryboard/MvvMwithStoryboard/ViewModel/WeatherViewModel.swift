//
//  WeatherViewModel.swift
//  MvvMwithStoryboard
//
//  Created by Hilal Öztemel on 22.03.2023.
//

import Foundation

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

