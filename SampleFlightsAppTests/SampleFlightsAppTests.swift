// Copyright 2020 Go Travel Un Limited
// This code is distributed under the terms and conditions of the MIT license.

import XCTest
import AviasalesSDK
import AviasalesKit

class SampleFlightsAppTests: XCTestCase {

    func testMetadataHeader() {
        let metadata = AviasalesSDK.sharedInstance().serviceLocator.metadataBuilder.metadata(withSource: nil)

        let affiliateMarker = metadata["affiliate_marker"] as! String
        var partnerMarker = AppCredentials.current.partnerMarker() ?? ""
        if partnerMarker.isEmpty {
            partnerMarker = "sdk"
        }
        XCTAssertEqual(affiliateMarker, partnerMarker)

        let host = metadata["host"] as! String
        XCTAssertTrue(host.contains("sdk"))
    }
}
