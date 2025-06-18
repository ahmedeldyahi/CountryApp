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
    private let locationManager:LocationManagerContract
    private let countryService: CountryServiceContract
    
    init(
        countryService: CountryServiceContract = CountryServiceImpl(),
        locationManager:LocationManagerContract = LocationManager()
    ) {
        self.countryService = countryService
        self.locationManager = locationManager
        
        Task {
            await loadInitialCountry()
        }
    }
    
    func loadInitialCountry() async {
        let code = await locationManager.getCountryCode() ?? "US"
        do {
            if let country = try await countryService.fetchCountry(by: code) {
                await MainActor.run { self.countries = [country] }
            }
        } catch {
            print("Error loading initial country: \(error)")
        }
    }
    
    func addCountry(_ country: Country) {
        guard countries.count < 5, !countries.contains(country) else { return }
        countries.append(country)
    }
    
    func removeCountry(atOffsets offsets: IndexSet) {
        countries.remove(atOffsets: offsets)
    }
}
