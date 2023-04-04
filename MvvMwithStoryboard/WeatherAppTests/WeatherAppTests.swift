//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Hilal Öztemel on 3.04.2023.
//

import XCTest
@testable import MvvMwithStoryboard
final class TestWeatherAppTests: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
    }
    
    func testTempFormaterTest(){
        let sut = FormattedData()
        let actual = sut.formatTemperature(67.98)
        let expected = "68°"
        XCTAssertEqual(actual,expected)
    }
    
    func testDayFormaterTest(){
        let sut = FormattedData()
        let actual = sut.formatDate(1680516000)
        let expected = "Pazartesi"
        XCTAssertEqual(actual, expected)
    }
    
    func testGetApiDataTest(){
        let validJSON = """
                {
                    "lat": 41.0082,
                    "lon": 28.9784,
                    "timezone": "Europe/Istanbul",
                    "timezone_offset": 10800,
                    "current": {
                        "dt": 1680532527,
                        "sunrise": 1680493492,
                        "sunset": 1680539387,
                        "temp": 17.84,
                        "feels_like": 17.32,
                        "pressure": 1007,
                        "humidity": 63,
                        "dew_point": 10.71,
                        "uvi": 0.3,
                        "clouds": 0,
                        "visibility": 10000,
                        "wind_speed": 8.75,
                        "wind_deg": 20,
                        "weather": [
                            {
                                "id": 800,
                                "main": "Clear",
                                "description": "clear sky",
                                "icon": "01d"
                            }
                        ]
                    },
                    "daily": [
                        {
                            "dt": 1680516000,
                            "sunrise": 1680493492,
                            "sunset": 1680539387,
                            "moonrise": 1680529680,
                            "moonset": 1680490140,
                            "moon_phase": 0.41,
                            "temp": {
                                "day": 15.54,
                                "min": 11.48,
                                "max": 18,
                                "night": 13.4,
                                "eve": 17.27,
                                "morn": 11.49
                            },
                            "feels_like": {
                                "day": 14.95,
                                "night": 12.65,
                                "eve": 16.75,
                                "morn": 11.25
                            },
                            "pressure": 1010,
                            "humidity": 69,
                            "dew_point": 9.59,
                            "wind_speed": 7.08,
                            "wind_deg": 54,
                            "wind_gust": 13.44,
                            "weather": [
                                {
                                    "id": 501,
                                    "main": "Rain",
                                    "description": "moderate rain",
                                    "icon": "10d"
                                }
                            ],
                            "clouds": 100,
                            "pop": 0.83,
                            "rain": 6.51,
                            "uvi": 2.84
                        },
                        {
                            "dt": 1680602400,
                            "sunrise": 1680579793,
                            "sunset": 1680625850,
                            "moonrise": 1680619860,
                            "moonset": 1680577800,
                            "moon_phase": 0.44,
                            "temp": {
                                "day": 16.59,
                                "min": 11.27,
                                "max": 18.25,
                                "night": 11.82,
                                "eve": 13.22,
                                "morn": 11.27
                            },
                            "feels_like": {
                                "day": 15.74,
                                "night": 11.38,
                                "eve": 12.58,
                                "morn": 10.7
                            },
                            "pressure": 1003,
                            "humidity": 55,
                            "dew_point": 6.49,
                            "wind_speed": 5.57,
                            "wind_deg": 69,
                            "wind_gust": 10.45,
                            "weather": [
                                {
                                    "id": 502,
                                    "main": "Rain",
                                    "description": "heavy intensity rain",
                                    "icon": "10d"
                                }
                            ],
                            "clouds": 93,
                            "pop": 1,
                            "rain": 7.54,
                            "uvi": 4.76
                        },
                        {
                            "dt": 1680688800,
                            "sunrise": 1680666094,
                            "sunset": 1680712313,
                            "moonrise": 1680710040,
                            "moonset": 1680665400,
                            "moon_phase": 0.47,
                            "temp": {
                                "day": 7.72,
                                "min": 7.35,
                                "max": 12,
                                "night": 7.35,
                                "eve": 7.54,
                                "morn": 9.71
                            },
                            "feels_like": {
                                "day": 4.78,
                                "night": 4.87,
                                "eve": 5.58,
                                "morn": 7.36
                            },
                            "pressure": 1012,
                            "humidity": 82,
                            "dew_point": 4.72,
                            "wind_speed": 6.56,
                            "wind_deg": 354,
                            "wind_gust": 10.8,
                            "weather": [
                                {
                                    "id": 501,
                                    "main": "Rain",
                                    "description": "moderate rain",
                                    "icon": "10d"
                                }
                            ],
                            "clouds": 100,
                            "pop": 0.93,
                            "rain": 4.91,
                            "uvi": 2.79
                        },
                        {
                            "dt": 1680775200,
                            "sunrise": 1680752396,
                            "sunset": 1680798777,
                            "moonrise": 1680800340,
                            "moonset": 1680753060,
                            "moon_phase": 0.5,
                            "temp": {
                                "day": 11.28,
                                "min": 7.09,
                                "max": 12.18,
                                "night": 10.24,
                                "eve": 11.71,
                                "morn": 7.38
                            },
                            "feels_like": {
                                "day": 10.13,
                                "night": 9.25,
                                "eve": 10.56,
                                "morn": 5.96
                            },
                            "pressure": 1013,
                            "humidity": 64,
                            "dew_point": 4.55,
                            "wind_speed": 3.64,
                            "wind_deg": 29,
                            "wind_gust": 5.02,
                            "weather": [
                                {
                                    "id": 500,
                                    "main": "Rain",
                                    "description": "light rain",
                                    "icon": "10d"
                                }
                            ],
                            "clouds": 26,
                            "pop": 0.88,
                            "rain": 0.72,
                            "uvi": 4.64
                        },
                        {
                            "dt": 1680861600,
                            "sunrise": 1680838698,
                            "sunset": 1680885240,
                            "moonrise": 1680890820,
                            "moonset": 1680840780,
                            "moon_phase": 0.54,
                            "temp": {
                                "day": 12.04,
                                "min": 8.74,
                                "max": 12.8,
                                "night": 9.05,
                                "eve": 11.21,
                                "morn": 8.74
                            },
                            "feels_like": {
                                "day": 10.92,
                                "night": 6.29,
                                "eve": 10.14,
                                "morn": 7.23
                            },
                            "pressure": 1014,
                            "humidity": 62,
                            "dew_point": 4.8,
                            "wind_speed": 6.36,
                            "wind_deg": 42,
                            "wind_gust": 8.21,
                            "weather": [
                                {
                                    "id": 500,
                                    "main": "Rain",
                                    "description": "light rain",
                                    "icon": "10d"
                                }
                            ],
                            "clouds": 79,
                            "pop": 0.25,
                            "rain": 0.14,
                            "uvi": 0.81
                        },
                        {
                            "dt": 1680948000,
                            "sunrise": 1680925000,
                            "sunset": 1680971703,
                            "moonrise": 1680981420,
                            "moonset": 1680928680,
                            "moon_phase": 0.57,
                            "temp": {
                                "day": 12.07,
                                "min": 7.53,
                                "max": 12.07,
                                "night": 9.29,
                                "eve": 10.77,
                                "morn": 7.53
                            },
                            "feels_like": {
                                "day": 10.95,
                                "night": 6.39,
                                "eve": 9.7,
                                "morn": 5.24
                            },
                            "pressure": 1017,
                            "humidity": 62,
                            "dew_point": 4.99,
                            "wind_speed": 6.58,
                            "wind_deg": 39,
                            "wind_gust": 9.34,
                            "weather": [
                                {
                                    "id": 803,
                                    "main": "Clouds",
                                    "description": "broken clouds",
                                    "icon": "04d"
                                }
                            ],
                            "clouds": 56,
                            "pop": 0,
                            "uvi": 1
                        },
                        {
                            "dt": 1681034400,
                            "sunrise": 1681011303,
                            "sunset": 1681058166,
                            "moonrise": 1681072200,
                            "moonset": 1681016820,
                            "moon_phase": 0.61,
                            "temp": {
                                "day": 10.93,
                                "min": 8.63,
                                "max": 10.93,
                                "night": 9.13,
                                "eve": 9.7,
                                "morn": 8.77
                            },
                            "feels_like": {
                                "day": 10.06,
                                "night": 5.96,
                                "eve": 7,
                                "morn": 6.07
                            },
                            "pressure": 1015,
                            "humidity": 76,
                            "dew_point": 6.8,
                            "wind_speed": 6.54,
                            "wind_deg": 28,
                            "wind_gust": 11.39,
                            "weather": [
                                {
                                    "id": 501,
                                    "main": "Rain",
                                    "description": "moderate rain",
                                    "icon": "10d"
                                }
                            ],
                            "clouds": 100,
                            "pop": 1,
                            "rain": 4.72,
                            "uvi": 1
                        },
                        {
                            "dt": 1681120800,
                            "sunrise": 1681097607,
                            "sunset": 1681144630,
                            "moonrise": 0,
                            "moonset": 1681105440,
                            "moon_phase": 0.64,
                            "temp": {
                                "day": 7.42,
                                "min": 6.82,
                                "max": 8.77,
                                "night": 7.53,
                                "eve": 7.3,
                                "morn": 7.35
                            },
                            "feels_like": {
                                "day": 2.66,
                                "night": 3.25,
                                "eve": 2.78,
                                "morn": 2.65
                            },
                            "pressure": 1006,
                            "humidity": 91,
                            "dew_point": 5.9,
                            "wind_speed": 10.82,
                            "wind_deg": 311,
                            "wind_gust": 19.29,
                            "weather": [
                                {
                                    "id": 501,
                                    "main": "Rain",
                                    "description": "moderate rain",
                                    "icon": "10d"
                                }
                            ],
                            "clouds": 100,
                            "pop": 1,
                            "rain": 68.11,
                            "uvi": 1
                        }
                    ]
                }
              
             
             """
        let data = validJSON.data(using: .utf8)!
        let decoder = JSONDecoder()
        let weatherData = try! decoder.decode(WeatherData.self, from: data)

        let weatherAPI = Service()
        weatherAPI.getWeather(apikey: "8ddadecc7ae4f56fee73b2b405a63659", lat: 41.0082, lon: 28.9784) { result in
            switch result {
            case.success(let result) :
                XCTAssertEqual(result, weatherData)
            case .failure(_):
                print("fail")
            }

        }
    }
    

}
