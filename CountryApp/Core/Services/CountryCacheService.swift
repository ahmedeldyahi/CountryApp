//
//  CountryCache.swift
//  CountryApp
//
//  Created by Ahmed Eldyahi on 19/06/2025.
//


import SwiftData

protocol CountryCacheContract {
    func loadCachedCountries() async -> [Country]
    func saveCountries(_ countries: [Country]) async
}

final class CountryCacheService: CountryCacheContract {
    static let shared = CountryCacheService()
    
    func loadCachedCountries() async -> [Country] {
        do {
            let context = try ModelContext(.init(for: CachedCountry.self))
            let fetchDescriptor = FetchDescriptor<CachedCountry>()
            let cached = try context.fetch(fetchDescriptor)
            return cached.map { $0.toCountry() }
        } catch {
            print("Failed to load cached countries: \(error)")
            return []
        }
    }

    func saveCountries(_ countries: [Country]) async {
        do {
            let context = try ModelContext(.init(for: CachedCountry.self))
            try context.delete(model: CachedCountry.self)
            for country in countries {
                context.insert(CachedCountry(from: country))
            }
            try context.save()
        } catch {
            print("Failed to save cached countries: \(error)")
        }
    }
}
