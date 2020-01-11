//
//  HomeRobot.swift
//  KiMangaUITests
//
//  Created by Haithem Ben harzallah on 21/06/2019.
//  Copyright © 2019 HB Media. All rights reserved.
//

import XCTest

final class HomeRobot: Robot, ViewRobot {
    let context: RobotContext
    let associatedView: String = "home"

    init(_ context: RobotContext) {
        self.context = context
    }

    @discardableResult
    func waitLoadingContent() -> Self {
        let exp = XCTestExpectation(description: "Test after 3 seconds")
        let result = XCTWaiter.wait(for: [exp], timeout: 3.0)
        if result == XCTWaiter.Result.timedOut {
            let cell = app.tables.element.cells

            XCTAssertGreaterThan(cell.count, 1)
        } else {
            XCTFail("Delay interrupted")
        }
        
        return self
    }

    @discardableResult
    func show() -> Self {
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons.element(boundBy: 0).tap()
        return self
    }

    @discardableResult
    func showDetail() -> Self {
        let cell = app.tables.element.cells
        cell.firstMatch.tap()
        return self
    }

    @discardableResult
    func scroll() -> Self {
        let table = app.descendants(matching: .table).firstMatch

        table.swipeUp()
        table.swipeDown()

        return self
    }

    @discardableResult
    func displayedEmptyStateView() -> Self {
        let emptyStateView = app.otherElements["empty_state_view"]
        XCTAssertTrue(emptyStateView.waitForExistence(timeout: 0.2))
        return self
    }
}
