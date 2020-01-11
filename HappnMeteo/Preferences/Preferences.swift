//
//  Constants.swift
//  HappnMeteo
//
//  Created by Haithem Ben harzallah on 11/01/2020.
//  Copyright © 2020 HB Media. All rights reserved.
//

import Foundation

struct Preferences {

    @UserDefault("forecast_days", defaultValue: 5)
    static var forecastDays: Int

    @UserDefault("city", defaultValue: "Paris")
    static var city: String

    @UserDefault("cache_meteo", defaultValue: nil)
    static var cacheMeteo: Data?
}
