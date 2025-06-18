//
//  CountryAppApp.swift
//  CountryApp
//
//  Created by Ahmed Eldyahi on 18/06/2025.
//

import SwiftUI

@main
struct CountryAppApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: MainViewModel())
        }
    }
}
