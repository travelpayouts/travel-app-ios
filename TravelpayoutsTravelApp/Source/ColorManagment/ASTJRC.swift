// Copyright 2019 Go Travel Un Limited
// This code is distributed under the terms and conditions of the MIT license.

import Foundation
import SharedDesignKit

class ASTJRC: JRC {

    static func setup() {
        let instance = ASTJRC()
        JRC.overrideCurrent(instance)
    }

    // Theme colors were moved to default_config.plist

    // MARK: Overrides

    // Color override example
//    override func SEARCH_FORM_BACKGROUND() -> UIColor {
//        return .green
//    }

    // Color example with iOS 13 dark mode support (requires Xcode 11)
//    override func COMMON_BACKGROUND() -> UIColor {
//        return UIColor.make(UIColor(hex: 0xffffff), dark: UIColor(hex: 0x0A0A0A))
//    }
}
