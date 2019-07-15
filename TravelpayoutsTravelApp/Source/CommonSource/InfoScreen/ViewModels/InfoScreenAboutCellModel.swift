// Copyright 2019 Go Travel Un Limited
// This code is distributed under the terms and conditions of the MIT license.

struct InfoScreenAboutCellModel: InfoScreenCellModelProtocol, InfoScreenAboutCellProtocol {
    let type = InfoScreenCellModelType.about
    let icon: String
    let logo: String?
    let name: String?
    let description: String?
    let separator: Bool
}
