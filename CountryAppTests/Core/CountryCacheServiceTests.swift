//
//  CountryCacheServiceTests.swift
//  CountryApp
//
//  Created by Ahmed Eldyahi on 19/06/2025.
//

import XCTest
import SwiftData
@testable import CountryApp

final class CountryCacheServiceTests: XCTestCase {
    private var context: ModelContext!
    private var service: CountryCacheService!

    override func setUpWithError() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: CachedCountry.self, configurations: config)
        context = ModelContext(container)
        service = CountryCacheService()
    }

    func testSaveAndLoadCountries_shouldReturnSavedCountries() async {
        let sample = Country(
            name: "Egypt",
            capital: "Cairo",
            currency: "EGP",
            flagURL: "https://flagcdn.com/eg.svg",
            code: "EG",
            region: "Africa",
            subregion: "Northern Africa",
            population: 100_000_000,
            area: 1002450,
            timezones: ["UTC+2"],
            latitude: 26.0,
            longitude: 30.0
        )

        await service.saveCountries([sample])
        let result = await service.loadCachedCountries()

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.code, "EG")
        XCTAssertEqual(result.first?.name, "Egypt")
    }
}
//
