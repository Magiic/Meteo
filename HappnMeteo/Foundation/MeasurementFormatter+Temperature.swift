//
//  MeasurementFormatter+Temperature.swift
//  HappnMeteo
//
//  Created by Haithem Ben harzallah on 11/01/2020.
//  Copyright © 2020 HB Media. All rights reserved.
//

import Foundation

extension MeasurementFormatter {

    static let temp: MeasurementFormatter = {
        let formatter = MeasurementFormatter()
        formatter.numberFormatter.maximumFractionDigits = 0
        formatter.numberFormatter.allowsFloats = false
        formatter.numberFormatter.alwaysShowsDecimalSeparator = false
        return formatter
    }()

    static let pressure: MeasurementFormatter = {
        let formatter = MeasurementFormatter()
        return formatter
    }()
}
