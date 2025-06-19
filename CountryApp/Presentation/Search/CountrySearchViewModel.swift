//
//  CountrySearchViewModel.swift
//  CountryApp
//
//  Created by Ahmed Eldyahi on 19/06/2025.
//

import Combine

final class CountrySearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var searchResults: [Country] = []
    @Published var isLoading = false

    private let service: CountryServiceContract

    init(service: CountryServiceContract = CountryServiceImpl()) {
        self.service = service
    }

    @MainActor
    func performSearch() async {
        guard !searchText.isEmpty else {
            searchResults = []
            return
        }

        isLoading = true
        defer { isLoading = false }

        do {
            let results = try await service.searchCountries(by: searchText)
            searchResults = results
        } catch {
            searchResults = []
            print("Search error: \(error)")
        }
    }
}
