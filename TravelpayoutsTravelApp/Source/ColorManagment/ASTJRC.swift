// Copyright 2019 Go Travel Un Limited
// This code is distributed under the terms and conditions of the MIT license.

import Foundation
import AviasalesKit

class ASTJRC: JRC {

    static func setup() {
        let instance = ASTJRC()
        JRC.overrideCurrent(instance)
    }

    // MARK: Overrides

    override func THEME_COLOR() -> UIColor {
        return ColorSchemeManager.shared.current.mainColor
    }

    override func SECOND_THEME_COLOR() -> UIColor {
        return ColorSchemeManager.shared.current.actionColor
    }

    // Color override example
//    override func SEARCH_FORM_BACKGROUND() -> UIColor {
//        return .green
//    }

    // Color example with iOS 13 dark mode support (requires Xcode 11)
//    override func COMMON_BACKGROUND() -> UIColor {
//        return UIColor.make(UIColor(hex: 0xffffff), dark: UIColor(hex: 0x0A0A0A))
//    }
}
