// Copyright 2019 Go Travel Un Limited
// This code is distributed under the terms and conditions of the MIT license.

struct InfoScreenRateCellModel: InfoScreenCellModelProtocol, InfoScreenRateCellProtocol {
    let type = InfoScreenCellModelType.rate
    let name: String?
}
