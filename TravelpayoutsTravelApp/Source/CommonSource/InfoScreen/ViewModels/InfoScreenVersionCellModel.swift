// Copyright 2019 Go Travel Un Limited
// This code is distributed under the terms and conditions of the MIT license.

struct InfoScreenVersionCellModel: InfoScreenCellModelProtocol, InfoScreenVersionCellProtocol {
    let type = InfoScreenCellModelType.version
    let version: String?
}
