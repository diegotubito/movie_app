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
        // Verificar que el SplashView esté visible
        let splashText = app.staticTexts["Splash View"]
        XCTAssertTrue(splashText.waitForExistence(timeout: 3), "The SplashView should be visible")

        // Esperar a que el TabBarView aparezca
        let homeTabBar = app.tabBars.buttons["Home"]
        XCTAssertTrue(homeTabBar.waitForExistence(timeout: 5), "The TabBarView should appear after the splash")
        
        // Verificar que la transición al Home haya ocurrido
    //    homeTabBar.tap()
    //    let homeText = app.staticTexts["Home View"]
    //    XCTAssertTrue(homeText.exists, "The Home View should be visible")
    }
}
