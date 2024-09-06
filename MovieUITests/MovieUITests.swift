//
//  MovieUITests.swift
//  MovieUITests
//
//  Created by David Diego Gomez on 04/09/2024.
//

import XCTest

final class MovieUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["ui-testing"]
        app.launchEnvironment = ["network-success": "1"]
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testSplashAndTransitionToHome() throws {
        let splashText = app.staticTexts["Play Movies"]
        XCTAssertTrue(splashText.waitForExistence(timeout: 3), "The SplashView should be visible")

        let homeTabBar = app.tabBars.buttons["Home"]
        XCTAssertTrue(homeTabBar.waitForExistence(timeout: 5), "The TabBarView should appear after the splash")
        
    }
}
