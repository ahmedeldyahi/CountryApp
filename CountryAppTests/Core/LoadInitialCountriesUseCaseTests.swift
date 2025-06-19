//
//  LoadInitialCountriesUseCaseTests.swift
//  CountryApp
//
//  Created by Ahmed Eldyahi on 19/06/2025.
//

import XCTest
@testable import CountryApp

final class LoadInitialCountriesUseCaseTests: XCTestCase {
    private var mockService: MockCountryService!
    private var mockLocation: MockLocationManager!
    private var mockCache: MockCountryCacheService!
    private var useCase: LoadInitialCountriesUseCase!

    override func setUp() {
        super.setUp()
        mockService = MockCountryService()
        mockLocation = MockLocationManager()
        mockCache = MockCountryCacheService()
        useCase = LoadInitialCountriesUseCase(
            countryService: mockService,
            locationManager: mockLocation,
            countryCache: mockCache
        )
    }

    func testExecute_shouldReturnCachedCountriesIfExists() async {
        let cached = [makeCountry("EG")]
        mockCache.savedCountries = cached

        let result = await useCase.execute()

        XCTAssertEqual(result, cached)
    }

    func testExecute_shouldReturnCountryFromLocationIfCacheIsEmpty() async {
        mockCache.savedCountries = []
        mockLocation.mockCode = "IT"
        let expected = makeCountry("IT")
        mockService.mockSearchResult = [expected]

        let result = await useCase.execute()

        XCTAssertEqual(result, [expected])
    }

    func testExecute_shouldFallbackToDefaultCountryIfLocationFails() async {
        mockCache.savedCountries = []
        mockLocation.mockCode = nil
        let expected = makeCountry("USA")
        mockService.mockSearchResult = [expected]

        let result = await useCase.execute()

        XCTAssertEqual(result, [expected])
    }

    func testExecute_shouldReturnEmptyArrayOnFailure() async {
        mockCache.savedCountries = []
        mockLocation.mockCode = "FR"
        mockService.shouldThrow = true

        let result = await useCase.execute()

        XCTAssertTrue(result.isEmpty)
    }

    // MARK: - Helpers

    private func makeCountry(_ code: String) -> Country {
        Country(
            name: code,
            capital: "Capital",
            currency: "CUR",
            flagURL: "https://flagcdn.com/\(code.lowercased()).png",
            code: code,
            region: nil,
            subregion: nil,
            population: nil,
            area: nil,
            timezones: nil,
            latitude: nil,
            longitude: nil
        )
    }
}

final class MockLocationManager: LocationManagerContract {
    var mockCode: String?

    func getCountryCode() async -> String? {
        return mockCode
    }
}
