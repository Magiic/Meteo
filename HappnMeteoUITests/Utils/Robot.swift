//
//  Robot.swift
//  RobotPatternTests
//
//  Created by Haithem Ben harzallah on 25/01/2019.
//  Copyright © 2019 Haïthem Ben Harzallah. All rights reserved.
//

import XCTest

struct RobotContext {
    let app: XCUIApplication
}

protocol Robot {
    var context: RobotContext { get }

    init(_ context: RobotContext)
}

extension Robot {

    var app: XCUIApplication {
        return context.app
    }

    @discardableResult
    func takeSnapshot(_ name: String) -> Self {
        return Self(context)
    }

    @discardableResult
    func tapBackButton() -> Self {
        let button = app.navigationBars.buttons.element(boundBy: 0)
        button.tap()

        return Self(context)
    }

    @discardableResult
    func assertAlertExists() -> Self {
        XCTAssertTrue(app.otherElements["custom_alert_view"].exists)

        return Self(context)
    }
}

protocol ViewRobot {
    var associatedView: String { get }
}

extension ViewRobot where Self: Robot {

    @discardableResult
    func waitAppearance() -> Self {
        _ = app.otherElements[associatedView].waitForExistence(timeout: UITestsConstants.appearanceTime)
        return self
    }

    @discardableResult
    func waitAppearanceFollowingNetworkAccess() -> Self {
        _ = app.otherElements[associatedView].waitForExistence(timeout: UITestsConstants.fetchTime)
        return self
    }

    @discardableResult
    func waitAppearanceFollowingTimeConsumingComputation() -> Self {
        _ = app.otherElements[associatedView].waitForExistence(timeout: UITestsConstants.computationTime)
        return self
    }

    @discardableResult
    func isDisplayed() -> Self {
        let view = app.otherElements[associatedView]
        XCTAssertTrue(view.exists)
        
        return self
    }
}

