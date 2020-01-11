//
//  StyleSheet+Color.swift
//  HappnMeteo
//
//  Created by Haithem Ben harzallah on 11/01/2020.
//  Copyright © 2020 HB Media. All rights reserved.
//

import UIKit

private class ColorClass {}

extension StyleSheet {
    struct Color {
        static var primaryBack: UIColor {
            if #available(iOS 13.0, *) {
                return UIColor.systemBackground
            } else {
                return UIColor.white
            }
        }

        static var error: UIColor {
            if #available(iOS 13.0, *) {
                return UIColor.systemRed
            } else {
                return UIColor.red
            }
        }

        static var primaryText: UIColor {
            if #available(iOS 13.0, *) {
                return UIColor.label
            } else {
                return UIColor.black
            }
        }

        static var secondaryText: UIColor {
            if #available(iOS 13.0, *) {
                return UIColor.secondaryLabel
            } else {
                return UIColor.lightGray
            }
        }

        static var highlight: UIColor {
            UIColor.blue
        }
    }
}
