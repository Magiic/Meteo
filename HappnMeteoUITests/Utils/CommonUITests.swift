//
//  CommonUITests.swift
//  RobotPatternTests
//
//  Created by Haithem Ben harzallah on 25/01/2019.
//  Copyright © 2019 Haïthem Ben Harzallah. All rights reserved.
//

import XCTest

class CommonUITests: XCTestCase {

    var app: XCUIApplication = XCUIApplication()
    //var snapshotter: Snapshotter!

    var context: RobotContext {
        return RobotContext(
            app: app
        )
    }

    override func setUp() {
        super.setUp()

        continueAfterFailure = false

        app.launchArguments += [UITestsConstants.uitest]

        context.app.launch()
    }

    func takeSnapshot(name: String, in activity: XCTActivity) {
        let screenshot = app.windows.firstMatch.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.lifetime = .keepAlways
        attachment.name = name
        activity.add(attachment)
    }

    func takeSnapshot(name: String) {
        app.windows.firstMatch.screenshot()
    }
}
