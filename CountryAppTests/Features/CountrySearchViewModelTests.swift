//
//  CountrySearchViewModelTests.swift
//  CountryApp
//
//  Created by Ahmed Eldyahi on 19/06/2025.
//

import XCTest
@testable import CountryApp

final class CountrySearchViewModelTests: XCTestCase {
    private var viewModel: CountrySearchViewModel!
    private var mockService: MockCountryService!

    override func setUp() {
        super.setUp()
        mockService = MockCountryService()
        viewModel = CountrySearchViewModel(service: mockService)
    }

    func testPerformSearch_withValidInput_shouldUpdateResults() async {
        let expected = Country(
            name: "Japan",
            capital: "Tokyo",
            currency: "JPY",
            flagURL: "https://flagcdn.com/jp.svg",
            code: "JPN",
            region: "Asia",
            subregion: nil,
            population: nil,
            area: nil,
            timezones: nil,
            latitude: nil,
            longitude: nil
        )

        mockService.mockSearchResult = [expected]
        viewModel.searchText = "Japan"

        await viewModel.performSearch()

        XCTAssertEqual(viewModel.searchResults, [expected])
    }

    func testPerformSearch_withEmptyInput_shouldClearResults() async {
        viewModel.searchText = ""
        viewModel.searchResults = [Country(name: "France", capital: "Paris", currency: "EUR", flagURL: "", code: "FR", region: nil, subregion: nil, population: nil, area: nil, timezones: nil, latitude: nil, longitude: nil)]

        await viewModel.performSearch()

        XCTAssertTrue(viewModel.searchResults.isEmpty)
    }
}

final class MockCountryService: CountryServiceContract {
    var mockSearchResult: [Country] = []
    var shouldThrow = false

    func fetchCountry(by code: String) async throws -> Country? {
        if shouldThrow { throw AppError.decodingFailed }
       return  mockSearchResult.first
    }

    func searchCountries(by name: String) async throws -> [Country] {
        mockSearchResult
    }
}

