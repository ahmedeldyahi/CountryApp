//
//  LoadInitialCountriesUseCaseContract.swift
//  CountryApp
//
//  Created by Ahmed Eldyahi on 19/06/2025.
//


protocol LoadInitialCountriesUseCaseContract {
    func execute() async -> [Country]
}

struct LoadInitialCountriesUseCase: LoadInitialCountriesUseCaseContract {
    private let countryService: CountryServiceContract
    private let locationManager: LocationManagerContract
    private let countryCache: CountryCacheContract
    
    init(
        countryService: CountryServiceContract = CountryServiceImpl(),
        locationManager: LocationManagerContract = LocationManager(),
        countryCache: CountryCacheContract = CountryCacheService.shared
    ) {
        self.countryService = countryService
        self.locationManager = locationManager
        self.countryCache = countryCache
    }
    
    func execute() async -> [Country] {
        let cached = await countryCache.loadCachedCountries()
        if !cached.isEmpty { return cached }

        let code = await locationManager.getCountryCode() ?? "USA"
        do {
            if let country = try await countryService.fetchCountry(by: code) {
                let result = [country]
                return result
            }
        } catch {
            print("LoadInitialCountries error: \(error)")
        }

        return []
    }
}
