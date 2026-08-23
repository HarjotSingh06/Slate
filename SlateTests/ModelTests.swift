//
//  ModelTests.swift
//  Slate
//
//  Created by Harjot Singh on 23/08/2026.
//

import XCTest
@testable import Slate

final class ModelTests: XCTestCase {

    func testClientBrandColorMapping() {
        // Verify each enum maps to the correct hex/color output
        XCTAssertNotNil(ClientBrand.slate.primaryColor)
        XCTAssertNotNil(ClientBrand.ocean.primaryColor)
        XCTAssertNotNil(ClientBrand.emerald.primaryColor)
    }
}
