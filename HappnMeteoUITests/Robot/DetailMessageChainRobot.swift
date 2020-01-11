//
//  DetailMessageChainRobot.swift
//  BeChainUITests
//
//  Created by Haithem Ben harzallah on 27/12/2019.
//  Copyright © 2019 HB Media. All rights reserved.
//

import XCTest

final class DetailMessageChainRobot: Robot, ViewRobot {
    let context: RobotContext
    let associatedView: String = "detail_message_chain_view"

    init(_ context: RobotContext) {
        self.context = context
        waitAppearance()
    }

    @discardableResult
    func scrollToBottom() -> Self {
        let table = app.descendants(matching: .table).firstMatch

        table.swipeUp()

        return self
    }
}
