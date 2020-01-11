//
//  String+Localization.swift
//  RobotPatternTests
//
//  Created by Haithem Ben harzallah on 26/01/2019.
//  Copyright © 2019 Haïthem Ben Harzallah. All rights reserved.
//

import Foundation

private class UITestsPrivateClass {}

extension String {

    /**
     * This method gets the localized version of the string in the context of the UI
     * tests.
     */
    func ui_localized() -> String {
        let bundle = Bundle(for: UITestsPrivateClass.self)
        let value = bundle.localizedString(forKey: self, value: nil, table: nil)

        return value
    }

}
/*
var currentLanguage: (langCode: String, localeCode: String)? {
    let currentLocale = Locale(identifier: Locale.preferredLanguages.first!)
    guard let langCode = currentLocale.languageCode else {
        return nil
    }
    var localeCode = langCode
    if let scriptCode = currentLocale.scriptCode {
        localeCode = "\(langCode)-\(scriptCode)"
    } else if let regionCode = currentLocale.regionCode {
        localeCode = "\(langCode)-\(regionCode)"
    }
    return (langCode, localeCode)
}

func localizedString(_ key: String) -> String {
    let testBundle = Bundle(for: UITestsPrivateClass.self)
    if let currentLanguage = currentLanguage,
        let testBundlePath = testBundle.path(forResource: currentLanguage.localeCode, ofType: "lproj") ?? testBundle.path(forResource: currentLanguage.langCode, ofType: "lproj"),
        let localizedBundle = Bundle(path: testBundlePath)
    {
        return NSLocalizedString(key, bundle: localizedBundle, comment: "")
    }
    return "?"
}*/
