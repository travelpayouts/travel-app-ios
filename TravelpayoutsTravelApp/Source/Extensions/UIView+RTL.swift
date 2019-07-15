// Copyright 2019 Go Travel Un Limited
// This code is distributed under the terms and conditions of the MIT license.

extension UIView {

    var isRTL: Bool {
        return UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .rightToLeft
    }

    func transformRTL() {
        if isRTL {
            transform = CGAffineTransform(scaleX: -1, y: 1)
        }
    }

}
