//
//  ContentView.swift
//  TetGAPSI
//
//  Created by Sebastian TC on 28/09/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.isSearching) var isSearching
    @ObservedObject var viewModel = ViewModel()
    @State var page: Int = 1
    @State private var searchText = ""
    @State var loaded: Bool = true
    @State var searchResults: [Item] = []
    @State var suggestedSearches: [String] = []
    
    var body: some View {
        NavigationView {
            List(searchResults, id: \.self) {
                ItemView(model: $0)
                    .id(UUID().hashValue)

            }
            .searchable(text: $searchText) {
                SuggestionView(nameSuggestions: $suggestedSearches)
              }
            .navigationBarTitle("GAPSI")
            .onSubmit(of: .search) {
                if searchText.isEmpty {
                    viewModel.cancelTask()
                    searchResults = []
                }
                else {
                    DispatchQueue.main.async {
                        loaded = false
                    }
                    self.viewModel.fetchModels(search: searchText, page: page)
                    self.viewModel.saveSearch(searchText: searchText)
                }
            }
            .onChange(of: isSearching) { newValue in
                if !newValue {
                    viewModel.cancelTask()
                    viewModel.models?.item.props.pageProps.initialData.searchResult.itemStacks[0].items.removeAll()
                    searchResults = []
                }
            }
            
            ZStack {
                ProgressView()
            }
            
        }
        .onChange(of: viewModel.models?.item.props.pageProps.initialData.searchResult.itemStacks[0].items ?? searchResults) { newValue in
            searchResults = newValue
            loaded = true
        }
        .onAppear(perform: {
            suggestedSearches = viewModel.readSearches()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
