//
//  DetailMeteoUITests.swift
//  HappnMeteoUITests
//
//  Created by Haithem Ben harzallah on 11/01/2020.
//  Copyright © 2020 HB Media. All rights reserved.
//

import XCTest

class DetailMeteoUITests: CommonUITests {

    override func setUp() {
        context.app.launchArguments = [
            UITestsConstants.fakeMeteo]
        super.setUp()
    }

    func testDetail() {
        showDetail()
    }

}

private extension DetailMeteoUITests {
    func showDetail() {
        HomeRobot(context)
            .show()
            .waitLoadingContent()
            .showDetail()

        DetailMeteoRobot(context)
            .waitAppearance()
    }
}
