//
//  MainView.swift
//  CountryApp
//
//  Created by Ahmed Eldyahi on 18/06/2025.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    @State private var showSearch = false
    var body: some View {
        NavigationStack {
            Group {
                countryListView
            }
            .navigationTitle("Countries")
            .toolbar {
                addButton
            }
            .sheet(isPresented: $showSearch) {
                CountrySearchView { selected in
                    viewModel.addCountry(selected)
                    showSearch = false
                }
            }
            .navigationDestination(for: Country.self) { country in
                CountryDetailView(country: country)
            }
        }
    }
    
    private var countryListView: some View {
        Group {
            if viewModel.countries.isEmpty {
                emptyStateView
            } else {
                listView
            }
        }
    }
    
    private var listView: some View {
        List {
            ForEach(viewModel.countries) { country in
                NavigationLink(value: country) {
                    CountryRow(country: country)
                }
            }
            .onDelete(perform: viewModel.removeCountry)
        }
        .listStyle(.insetGrouped)
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "globe")
                .font(.system(size: 48))
                .foregroundStyle(.secondary)
            
            Text("No Countries Added")
                .font(.title2)
                .bold()
            
            Text("Add your first country using the + button")
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxHeight: .infinity)
    }
    
    private var addButton: some View {
        Button(action: { showSearch = true }) {
            Image(systemName: "plus")
                .font(.headline)
                .padding(8)
                .background(Circle().fill(.blue))
                .foregroundColor(.white)
        }
        .disabled(viewModel.countries.count >= 5)
        .opacity(viewModel.countries.count >= 5 ? 0.6 : 1)
    }
}

#Preview {
    MainView(viewModel: MainViewModel())
}
