//
//  ContentView.swift
//  CountryApp
//
//  Created by Ahmed Eldyahi on 18/06/2025.
//

import SwiftUI

struct ContentView: View {
    let networkManager = NetworkManager()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .task {
            
            await loadInitialCountry()
//            do {
//                let result: [CountryModel]  = try await networkManager.fetch(endpoint: APIEndpoint.countries(name: "eg"))
//                print(result)
//            } catch {
//                
//                print(error)
//            }
        }
        .padding()
    }
    
    
    func loadInitialCountry() async {
        let defaultCode = "US" // fallback if denied
        let locationManager = LocationManager()

        let code = await locationManager.getCountryCode() ?? defaultCode

        print("code from the location \(code)")
//        do {
//            if let country = try await countryService.fetchCountry(by: code) {
//                await MainActor.run {
//                    self.countries = [country]
//                }
//            }
//        } catch {
//            print("Failed to fetch country for code \(code): \(error)")
//        }
    }
}

#Preview {
    ContentView()
}


struct Country: Codable, Identifiable, Equatable {
    var id: String { code }
    let name: String
    let capital: String
    let currency: String
    let flagURL: String
    let code: String
}


struct CountryModel: Decodable {
    struct Name: Decodable { let common: String }
    struct Flags: Decodable { let png: String }
    struct Currency: Decodable { let name: String }

    let name: Name
    let capital: [String]?
    let currencies: [String: Currency]?
    let flags: Flags
    let cca3: String

    func toCountry() -> Country? {
        guard let capital = capital?.first,
              let currency = currencies?.first?.value.name else { return nil }

        return Country(
            name: name.common,
            capital: capital,
            currency: currency,
            flagURL: flags.png,
            code: cca3
        )
    }
}
