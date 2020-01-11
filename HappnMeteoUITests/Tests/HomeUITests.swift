//
//  HomeUITests.swift
//  KiMangaUITests
//
//  Created by Haithem Ben harzallah on 19/06/2019.
//  Copyright © 2019 HB Media. All rights reserved.
//

import XCTest

class HomeUITests: CommonUITests {

    override func setUp() {
        context.app.launchArguments = [
            UITestsConstants.fakeMeteo]
        super.setUp()
    }

    func testShowHomeFilled() {
        showHome()
    }

}

private extension HomeUITests {
    func showHome() {
        HomeRobot(context)
            .show()
            .waitLoadingContent()
    }
}
