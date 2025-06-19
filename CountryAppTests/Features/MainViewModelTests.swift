//
//  MainViewModelTests.swift
//  CountryApp
//
//  Created by Ahmed Eldyahi on 19/06/2025.
//

import XCTest
@testable import CountryApp

final class MainViewModelTests: XCTestCase {
    private var viewModel: MainViewModel!
    private var mockUseCase: MockLoadInitialCountriesUseCase!
    private var mockCache: MockCountryCacheService!

    override func setUp() {
        super.setUp()
        mockUseCase = MockLoadInitialCountriesUseCase()
        mockCache = MockCountryCacheService()
        viewModel = MainViewModel(loadInitialCountries: mockUseCase, countryCache: mockCache)
    }

    func testLoadInitialCountry_shouldSetCountries() async {
        let expectedCountry = Country(
            name: "Canada",
            capital: "Ottawa",
            currency: "CAD",
            flagURL: "https://flagcdn.com/ca.png",
            code: "CA",
            region: nil,
            subregion: nil,
            population: nil,
            area: nil,
            timezones: nil,
            latitude: nil,
            longitude: nil
        )
        mockUseCase.mockCountries = [expectedCountry]

        await viewModel.loadInitialCountry()

        XCTAssertEqual(viewModel.countries, [expectedCountry])
    }

    func testAddCountry_shouldAppendNewCountry() {
        let country = makeCountry("US")
        viewModel.addCountry(country)

        XCTAssertEqual(viewModel.countries, [country])
    }

    func testAddCountry_shouldNotAddDuplicate() {
        let country = makeCountry("US")
        viewModel.addCountry(country)
        viewModel.addCountry(country)

        XCTAssertEqual(viewModel.countries.count, 1)
    }

    func testAddCountry_shouldNotExceedFive() {
        for i in 0..<6 {
            let country = makeCountry("C\(i)")
            viewModel.addCountry(country)
        }

        XCTAssertEqual(viewModel.countries.count, 5)
    }

    func testRemoveCountry_shouldRemoveFromList() {
        let country1 = makeCountry("FR")
        let country2 = makeCountry("DE")
        viewModel.addCountry(country1)
        viewModel.addCountry(country2)

        viewModel.removeCountry(atOffsets: IndexSet(integer: 0))

        XCTAssertEqual(viewModel.countries.count, 1)
        XCTAssertEqual(viewModel.countries.first?.code, "DE")
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


final class MockLoadInitialCountriesUseCase: LoadInitialCountriesUseCaseContract {
    var mockCountries: [Country] = []

    func execute() async -> [Country] {
        return mockCountries
    }
}

final class MockCountryCacheService: CountryCacheContract {
    var savedCountries: [Country] = []

    func loadCachedCountries() async -> [Country] {
        return savedCountries
    }

    func saveCountries(_ countries: [Country]) async {
        savedCountries = countries
    }
}
