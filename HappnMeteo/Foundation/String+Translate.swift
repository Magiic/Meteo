//
//  String+Translate.swift
//  HappnMeteo
//
//  Created by Haithem Ben harzallah on 11/01/2020.
//  Copyright © 2020 HB Media. All rights reserved.
//

import Foundation

public extension String {
    func translated(comment: String? = nil) -> String {
        return NSLocalizedString(self, comment: comment ?? "")
    }
}
