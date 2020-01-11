//
//  XCUIApplication+Extension.swift
//  RobotPatternTests
//
//  Created by Haithem Ben harzallah on 25/01/2019.
//  Copyright © 2019 Haïthem Ben Harzallah. All rights reserved.
//

import XCTest

extension XCUIApplication {

    func waitForLoadingIndicatorToDisappear(within timeout: TimeInterval = 30) {
        let loadingIndicator = activityIndicators.element(boundBy: 0)
        waitForElementToDisappear(loadingIndicator, within: timeout)
    }

    func waitForElementToDisappear(_ element: XCUIElement, within timeout: TimeInterval = 10) {
        let loadingIndicatorDisappeared = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "exists == false"),
            object: element
        )
        _ = XCTWaiter.wait(for: [loadingIndicatorDisappeared], timeout: timeout)
    }
}

extension XCUIApplication {

    func searchBarForIdentifier(_ identifier: String) -> XCUIElement {
        return otherElements[identifier].searchFields.firstMatch
    }
}

extension XCUIApplication {
    
    var contentFrame: CGRect {
        var contentFrame = frame
        let tabBar = tabBars.firstMatch
        if tabBar.exists && tabBar.isHittable { // tab bar is not hidden behind another element
            contentFrame = CGRect(
                x: contentFrame.origin.x,
                y: contentFrame.origin.y,
                width: contentFrame.width,
                height: contentFrame.height - tabBar.frame.height
            )
        }
        return contentFrame
    }
}
