//
//  WeatherData.swift
//  Calendar
//
//  Created by Xutw on 2020/11/17.
//

import Foundation

struct Weather: Codable {
    var name: String // city name
    var main: [String: Double] // temp, temp_max, temp_min, humidity
    var wind: [String: Double] // wind speed
    var weather: [WeatherInfo]
    
}



struct WeatherInfo: Codable {
    var id: Double
    var main: String
    var description: String // Describe the weather
    var icon: String
}



