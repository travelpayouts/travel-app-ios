// Copyright 2019 Go Travel Un Limited
// This code is distributed under the terms and conditions of the MIT license.

import XCTest
import SharedHTTPClient
import SharedAviasalesConfiguration

class TravelpayoutsTravelAppTests: XCTestCase {

    @MainActor
    func testMetadataHeader() throws {
        let rawMetadata = MetadataBuilder.makeDefault().build(nil)
        let metadata = try parseMetadata(rawMetadata)

        let affiliateMarker = try XCTUnwrap(metadata["affiliate_marker"])
        XCTAssertEqual(affiliateMarker, AppCredentials.current.partnerMarker())

        let host = try XCTUnwrap(metadata["host"])
        XCTAssertTrue(host.contains("sdk"))
    }

    private func parseMetadata(_ rawMetadata: MetadataBuilder.Metadata) throws -> [String: String] {
        let infoString = try XCTUnwrap(rawMetadata["Client-Device-Info"])
        let infoPairs = infoString.components(separatedBy: "; ")
        let metadata: [String: String] = infoPairs.reduce(into: [:]) { memo, pairString in
            let pair = pairString.components(separatedBy: "=")
            memo[pair[0]] = pair[1]
        }
        return metadata
    }
}
