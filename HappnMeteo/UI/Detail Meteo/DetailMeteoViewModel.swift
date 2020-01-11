//
//  DetailMeteoViewModel.swift
//  HappnMeteo
//
//  Created by Haithem Ben harzallah on 11/01/2020.
//  Copyright © 2020 HB Media. All rights reserved.
//

import Foundation

protocol DetailMeteoViewModelDelegate: AnyObject {
    func close()
}

protocol DetailMeteoViewModel: AnyObject {
    var delegate: DetailMeteoViewModelDelegate? { get set }

    var cityName: String { get }
    var descriptionWeather: String { get }
    var temperature: String { get }
    var minTemperature: String { get }
    var maxTemperature: String { get }
    var humidity: String { get }
    var pressure: String { get }
    var seaLevel: String { get }
    var feelTemperature: String { get }
    var clouds: String { get }
    var iconPathURL: String? { get }

    init(meteo: ForeCastMeteo)
    func close()
}

final class DetailMeteoViewModelImpl: DetailMeteoViewModel {
    var cityName: String { Preferences.city }

    var descriptionWeather: String { meteo.weather.first?.description ?? "" }

    var temperature: String { meteo.main.temp.formattedTemperature }

    var iconPathURL: String? { meteo.weather.first?.icon }

    // Next values are not used, missing time.

    var minTemperature: String { meteo.main.tempMin.formattedTemperature }

    var maxTemperature: String { meteo.main.tempMax.formattedTemperature }

    var humidity: String { String(meteo.main.humidity.percent ?? "") }

    var pressure: String { meteo.main.pressure.formattedPressure }

    var seaLevel: String { meteo.main.seaLevel.formattedPressure }

    var feelTemperature: String { meteo.main.feelsLike.formattedTemperature }

    var clouds: String { meteo.clouds.all.percent ?? "" }

    weak var delegate: DetailMeteoViewModelDelegate?

    let meteo: ForeCastMeteo

    init(meteo: ForeCastMeteo) {
        self.meteo = meteo
    }

    func close() {
        delegate?.close()
    }
}
