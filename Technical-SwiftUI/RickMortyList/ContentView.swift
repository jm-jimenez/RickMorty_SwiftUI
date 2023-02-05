//
//  ContentView.swift
//  Technical-SwiftUI
//
//  Created by José María Jiménez on 5/2/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = RickMortyListViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults) { viewModel in
                    NavigationLink {
                        RickMortyDetailView(character: self.viewModel.getCharacterForViewModel(viewModel))
                    } label: {
                        RickMortyListRowView(viewModel: viewModel)
                    }
                }
            }
            .onAppear {
                viewModel.loadCharacters()
            }
            .navigationTitle("Characters")
            .navigationBarTitleDisplayMode(.inline)
        }
        .searchable(text: $searchText)
    }

    var searchResults: [RickMortyListRowViewModel] {
        searchText.isEmpty ? viewModel.viewModels : viewModel.viewModels.filter { $0.name.contains(searchText) }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
