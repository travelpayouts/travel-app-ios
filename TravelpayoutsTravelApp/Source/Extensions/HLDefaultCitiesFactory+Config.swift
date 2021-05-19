// Copyright 2019 Go Travel Un Limited
// This code is distributed under the terms and conditions of the MIT license.

import HotellookSDK
import HotellookKit
import ASTemplateConfiguration

extension HLDefaultCitiesFactory {

    static func configCity() -> HDKCity? {

        guard let id = ConfigManager.shared.hotelsCityID, let name = ConfigManager.shared.hotelsCityName, !id.isEmpty, !name.isEmpty else {
            return nil
        }

        return HDKCity(cityId: id,
                       name: name,
                       latinName: nil,
                       fullName: nil,
                       countryName: nil,
                       countryLatinName: nil,
                       countryCode: nil,
                       state: nil,
                       latitude: 0,
                       longitude: 0,
                       hotelsCount: 0,
                       cityCode: nil,
                       points: [],
                       seasons: [])
    }
}
