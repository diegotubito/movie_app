//
//  MovieUseCase.swift
//  MovieTests
//
//  Created by David Diego Gomez on 04/09/2024.
//

import XCTest
@testable import Movie

final class FetchPopularMoviesUseCaseTests: XCTestCase {
    
    var fetchPopularUseCase: FetchPopularUseCase!
    var repositoryMock: MovieRepositoryMock!

    override func setUp() {
        super.setUp()
        repositoryMock = MovieRepositoryMock()
        repositoryMock.mockFileName = "popular_movies_mock"
        fetchPopularUseCase = FetchPopularUseCase(repository: repositoryMock)
    }

    func testExecuteFetchPopularMovies() async throws {
        let response = try await fetchPopularUseCase.excecute()
        
        XCTAssertEqual(response.results.count, 20, "Expected 20 movies in the mock response")
        XCTAssertEqual(response.results.first?.originalTitle, "Deadpool & Wolverine", "The first movie should be 'Deadpool & Wolverine'")
    }
}

