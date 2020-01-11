//
//  XCUIElement+Extension.swift
//  RobotPatternTests
//
//  Created by Haithem Ben harzallah on 25/01/2019.
//  Copyright © 2019 Haïthem Ben Harzallah. All rights reserved.
//

import XCTest

extension XCUIElement {
    /**
     Removes any current text in the field before typing in the new value
     - Parameter text: the text to enter into the field
     */
    func clearAndEnterText(_ text: String) {
        clear()
        typeText(text)
    }

    /// Removes any current text in the field
    func clear() {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }

        // Sometimes the cursor is to the beggining of textfield and so don't remove text.
        // Tap the right corner of textfield to place the cursor at the end of text
        let lowerRightCorner = self.coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.9))
        lowerRightCorner.tap()

        let deleteString = repeatElement(
            XCUIKeyboardKey.delete.rawValue,
            count: stringValue.count
            ).joined()
        typeText(deleteString)
    }

    /**
     Scroll self until element is visible
     - Parameter element: element to find
     - Parameter application: main application
     */
    enum ScrollDirection {
        case horizontal
        case vertical
    }

    func scrollTo(_ element: XCUIElement,
                  in application: XCUIApplication,
                  direction: ScrollDirection = .vertical,
                  maxCount: Int = 20) {
        
        var counter = 0

        while !element.isVisible(in: application) && counter < maxCount {
            let endVector = direction == .vertical
                ? CGVector(dx: 0.5, dy: 0)
                : CGVector(dx: 0, dy: 0.5)
            let startCoordinate = coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
            let endCoordinate = coordinate(withNormalizedOffset: endVector)
            startCoordinate.press(forDuration: 0.01, thenDragTo: endCoordinate)
            counter += 1
        }
    }

    // MARK: - Private

    private func isVisible(in application: XCUIApplication) -> Bool {
        guard exists && !self.frame.isEmpty else {
            return false
        }

        return application.contentFrame.contains(frame)
    }
}
