//
//  ColorScheme.swift
//  AviasalesSDKTemplate
//
//  Created by Dim on 17.11.2017.
//  Copyright © 2017 Go Travel Un Limited. All rights reserved.
//

import UIKit

@objc protocol ColorScheme: NSObjectProtocol {
    var mainColor: UIColor { get set }
    var actionColor: UIColor { get set }
}
