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


