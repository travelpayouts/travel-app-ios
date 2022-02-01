// Copyright 2019 Go Travel Un Limited
// This code is distributed under the terms and conditions of the MIT license.

import UIKit
import SharedDesignKit

@objcMembers
public class ASTColorScheme: NSObject {

    // MARK: Base

    public static func mainColor() -> UIColor {
        return JRC.current().THEME_COLOR()
    }

    public static func actionColor() -> UIColor {
        return JRC.current().SECOND_THEME_COLOR()
    }

    // MARK: Background

    public static func mainBackgroundColor() -> UIColor {
        return JRC.current().COMMON_BACKGROUND()
    }

    public static func darkTextColor() -> UIColor {
        return JRC.current().COMMON_TEXT()
    }
}
