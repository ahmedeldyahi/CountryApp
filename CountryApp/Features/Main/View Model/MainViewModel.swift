//
//  MainViewModel.swift
//  CountryApp
//
//  Created by Ahmed Eldyahi on 18/06/2025.
//

import Combine
import SwiftUI

class MainViewModel: ObservableObject {
    @Published var countries: [Country] = []
    private let loadInitialCountries: LoadInitialCountriesUseCaseContract
    private let countryCache: CountryCacheContract
    
    init(
        loadInitialCountries: LoadInitialCountriesUseCaseContract = LoadInitialCountriesUseCase(),
        countryCache: CountryCacheContract = CountryCacheService.shared
    ) {
        self.loadInitialCountries = loadInitialCountries
        self.countryCache = countryCache
        
        Task {
            await loadInitialCountry()
        }
    }
    
    private func loadInitialCountry() async {
        let countries = await loadInitialCountries.execute()
        await MainActor.run {
            self.countries = countries
        }
    }
    
    func addCountry(_ country: Country) {
        guard countries.count < 5, !countries.contains(country) else { return }
        countries.append(country)
        Task {
            await countryCache.saveCountries(countries)
        }
    }
    
    func removeCountry(atOffsets offsets: IndexSet) {
        countries.remove(atOffsets: offsets)
        Task {
            await countryCache.saveCountries(countries)
        }
    }
}
