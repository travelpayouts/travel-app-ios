// Copyright 2019 Go Travel Un Limited
// This code is distributed under the terms and conditions of the MIT license.

import AviasalesKit
import ASTemplateConfiguration

extension JRSDKSearchInfoBuilder {

    static func buildTravelSegmentsBasedOnConfig() -> NSOrderedSet? {

        guard let origin = ConfigManager.shared.flightsOrigin, let destination = ConfigManager.shared.flightsDestination else {
            return nil
        }

        let airportsStorage = AviasalesSDK.sharedInstance().airportsStorage

        let travelSegmentBuilder = JRSDKTravelSegmentBuilder()

        travelSegmentBuilder.originAirport = airportsStorage.findAnything(byIATA: origin)
        travelSegmentBuilder.destinationAirport = airportsStorage.findAnything(byIATA: destination)
        travelSegmentBuilder.departureDate = nextWeekend()

        guard let travelSegment = travelSegmentBuilder.build() else {
            return nil
        }

        return NSOrderedSet(object: travelSegment)
    }
}

private func nextWeekend() -> Date? {
    let today = DateUtil.today()
    let calendar = AviasalesSDKDateUtils.gregorianCalendar()

    var weekend = today
    var interval: TimeInterval = .init()
    if calendar.nextWeekend(startingAfter: today, start: &weekend, interval: &interval) {
        return weekend
    }

    return nil
}
