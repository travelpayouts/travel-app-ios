// Copyright 2019 Go Travel Un Limited
// This code is distributed under the terms and conditions of the MIT license.

enum InfoScreenCellModelType {
    case about
    case rate
    case settings
    case email
    case external
    case version
}

protocol InfoScreenCellModelProtocol {
    var type: InfoScreenCellModelType { get }
}
