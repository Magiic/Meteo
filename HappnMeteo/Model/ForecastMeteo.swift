//
//  ForecastMeteo.swift
//  HappnMeteo
//
//  Created by Haithem Ben harzallah on 11/01/2020.
//  Copyright © 2020 HB Media. All rights reserved.
//

import Foundation

struct ForeCastMeteoList: Codable {
    let list: [ForeCastMeteo]
}

struct ForeCastMeteo: Codable {

    struct Main: Codable {
        private enum CodingKeys: String, CodingKey {
            case temp, pressure, humidity
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case seaLevel = "sea_level"
            case grndLevel = "grnd_level"
            case tempKf = "temp_kf"
        }

        let temp: Double
        let feelsLike: Double
        let tempMin: Double
        let tempMax: Double
        let pressure: Double
        let seaLevel: Double
        let grndLevel: Double
        let humidity: Int
        let tempKf: Double
    }

    let dt: Double
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let clouds: Cloud
}

struct Temperature: Codable {
    let day: Double
    let min: Double?
    let max: Double?
    let night: Double
    let eve: Double
    let morn: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Wind: Codable {
    let speed: Double
    let deg: Double
}

struct Cloud: Codable {
    let all: Int
}

extension ForeCastMeteo {

    var dayWeek: String {
        DateFormatter.dayWeek.string(from: dt.dateTimestamp)
    }
}

extension Double {

    var dateTimestamp: Date {
        Date(timeIntervalSince1970: TimeInterval(self))
    }

    var formattedTemperature: String {
        let measure = Measurement(value: self, unit: UnitTemperature.kelvin)

        return MeasurementFormatter.temp.string(from: measure)
    }

    var formattedPressure: String {
        let measure = Measurement(value: self, unit: UnitPressure.hectopascals)

        return MeasurementFormatter.pressure.string(from: measure)
    }
}

extension Int {
    var celciusTemp: String {
        Double(self).formattedTemperature
    }

    var percent: String? {
        NumberFormatter.percent.string(from: NSNumber(value: self))
    }
}
