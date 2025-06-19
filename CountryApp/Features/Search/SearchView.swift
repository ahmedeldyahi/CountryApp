//
//  SearchView.swift
//  CountryApp
//
//  Created by Ahmed Eldyahi on 19/06/2025.
//


import SwiftUI

struct CountrySearchView: View {
    @StateObject private var viewModel = CountrySearchViewModel()
    var onSelect: (Country) -> Void
    
    var body: some View {
        NavigationStack {
            VStack {
                searchField
                
                if viewModel.isLoading {
                    ProgressView()
                        .padding(.top, 24)
                } else {
                    searchResultsList
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Search Countries")
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: viewModel.searchText) { _, newValue in
                Task { await viewModel.performSearch() }
            }
        }
    }
    
    private var searchField: some View {
        TextField("Search for a country", text: $viewModel.searchText)
            .padding(12)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .autocorrectionDisabled()
            .overlay(
                HStack {
                    Spacer()
                    if !viewModel.searchText.isEmpty {
                        Button(action: { viewModel.searchText = "" }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                        .padding(.trailing, 8)
                    }
                }
            )
    }
    
    private var searchResultsList: some View {
        Group {
            if viewModel.searchResults.isEmpty && !viewModel.searchText.isEmpty {
                ContentUnavailableView("No Results", systemImage: "magnifyingglass")
            } else if viewModel.searchResults.isEmpty {
                emptyView
            } else {
                resultView
            }
        }
    }
    
    private var resultView: some View {
        
        List(viewModel.searchResults) { country in
            Button(action: { onSelect(country) }) {
                CountryRow(country: country)
            }
            .buttonStyle(.plain)
        }
        .listStyle(.plain)
    }
    
    private var emptyView: some View {
        VStack(spacing: 16) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 48))
                .foregroundStyle(.secondary)
            Text("Search for countries")
                .font(.title2)
            Text("Enter a country name to begin searching")
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(.top, 48)
    }
}

#Preview {
    CountrySearchView { country in
        print(country.name)
    }
}
