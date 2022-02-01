// Copyright 2019 Go Travel Un Limited
// This code is distributed under the terms and conditions of the MIT license.

struct InfoScreenExternalCellModel: InfoScreenCellModelProtocol {
    let type = InfoScreenCellModelType.external
    let name: String?
    let url: String?
}
