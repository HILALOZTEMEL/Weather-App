//
//  FormattedData.swift
//  MvvMwithStoryboard
//
//  Created by Hilal Öztemel on 3.04.2023.
//

import Foundation
class FormattedData {
    
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
    
}

