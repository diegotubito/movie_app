//
//  MovieTests.swift
//  MovieTests
//
//  Created by David Diego Gomez on 04/09/2024.
//

import XCTest
@testable import Movie

final class MovieRepositoryTests: XCTestCase {
    
    var repository: MovieRepositoryMock!

    override func setUp() {
        super.setUp()
        repository = MovieRepositoryMock()
    }

    func testFetchPopularMovies() async throws {
        repository.mockFileName = "popular_movies_mock"
        
        let response = try await repository.fetchPopularMovies(request: PopularMovieEntity.Request())
        
        XCTAssertEqual(response.results.count, 20, "Expected 20 movies in the mock response")
        XCTAssertEqual(response.results.first?.originalTitle, "Deadpool & Wolverine", "The first movie should be 'Deadpool & Wolverine'")
    }
}
