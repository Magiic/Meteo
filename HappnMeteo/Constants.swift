//
//  Constants.swift
//  HappnMeteo
//
//  Created by Haithem Ben harzallah on 11/01/2020.
//  Copyright © 2020 HB Media. All rights reserved.
//

import Foundation

struct Constants {

    // For this app, we get simple by store api key in constants but this is not secure
    static let apiKey = "1e0e8dd087ce484bc8334a09a3f229f1"

    // MARK: - API

    static let scheme = "http"
    static let host = "api.openweathermap.org"

    // MARK: API Forecast

    static let forcastPath = "/data/2.5/forecast"

    // MARK: API Icon
    static let schemeIcon = "http"
    static let hostIcon = "openweathermap.org"
    static let pathIcon = "/img/wn"
}
