//
//  viewModel.swift
//  MvvMwithStoryboard
//
//  Created by Hilal Öztemel on 21.03.2023.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var title : String = "-"
    @Published var descriptionText : String  = "-"
    @Published var temp : String = "-"
    @Published var timezone : String = "-"
    
    init(){
        fetchWeather()
    }
    
    func fetchWeather(){
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/onecall/timemachine?lat=60.99&lon=30.9&dt=1586468027&appid=01ea2ea579c4316d447ea4f8344f29b0")
        else{
            return
        }
        let task = URLSession.shared.dataTask(with: url){
            data,_,error in
            guard let data = data , error == nil else { return
                
            }
            // Convert data to Model
            do {
                let model = try JSONDecoder().decode(WeatherModel.self , from:data)
                DispatchQueue.main.async {
                    self.title = model.current.weather.first?.description ?? "NO TiTLE"
                    self.descriptionText = model.current.weather.first?.main ?? "NO Description"
                    self.temp = "\(model.current.temp)°"
                    self.timezone = model.timezone
                    
                }
            }catch{
                print("Failed")
            }
        }
        task.resume()
    }
}

