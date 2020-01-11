//
//  DetailMeteoRobot.swift
//  HappnMeteoUITests
//
//  Created by Haithem Ben harzallah on 11/01/2020.
//  Copyright © 2020 HB Media. All rights reserved.
//

import XCTest

final class DetailMeteoRobot: Robot, ViewRobot {
    let context: RobotContext
    let associatedView: String = "detail"

    init(_ context: RobotContext) {
        self.context = context
    }
}
