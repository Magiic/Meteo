//
//  StyleSheet+Icon.swift
//  HappnMeteo
//
//  Created by Haithem Ben harzallah on 11/01/2020.
//  Copyright © 2020 HB Media. All rights reserved.
//

import UIKit

extension StyleSheet {
    struct Icon {
        static var emptyImage: UIImage {
            if #available(iOS 13.0, *) {
                return UIImage(named: "image_placeholder")!
            } else {
                return UIImage(named: "image_placeholder")!
            }
        }

        static var close: UIImage {
            if #available(iOS 13.0, *) {
                return UIImage(systemName: "xmark")!
            } else {
                return UIImage(named: "close")!
            }
        }

        static var emptyHome: UIImage? {
            if #available(iOS 13.0, *) {
                return UIImage(systemName: "doc.circle.fill")
            } else {
                return UIImage(named: "document_fill")
            }
        }

        public struct TabBar {

            static var home: UIImage {
                if #available(iOS 13.0, *) {
                    return UIImage(systemName: "house.fill")!
                } else {
                    return UIImage(named: "home")!
                }
            }
        }
    }
}

