// Copyright 2019 Go Travel Un Limited
// This code is distributed under the terms and conditions of the MIT license.

import Foundation

@objcMembers
class ColorSchemeManager: NSObject {

    static let shared = ColorSchemeManager()

    var current: ColorScheme = PurpleColorScheme()
}
