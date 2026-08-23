//
//  ConfigManagerTests.swift
//  Slate
//
//  Created by Harjot Singh on 23/08/2026.
//

import XCTest
@testable import Slate

final class ConfigManagerTests: XCTestCase {

    func testBrandSwitchingUpdatesStateAndColor() {
        let config = ConfigManager.shared
        
        // 1. Set initial brand
        config.selectedBrand = .slate
        XCTAssertEqual(config.selectedBrand, .slate)
        
        // 2. Switch brand to Ocean
        config.selectedBrand = .ocean
        
        // 3. Assert brand and primary color updated
        XCTAssertEqual(config.selectedBrand, .ocean)
        XCTAssertNotEqual(config.selectedBrand, .slate)
    }
}
