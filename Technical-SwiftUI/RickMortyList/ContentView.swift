//
//  ContentView.swift
//  Technical-SwiftUI
//
//  Created by José María Jiménez on 5/2/23.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    @Bindable var store: StoreOf<RickMortyListFeature>
    
    var body: some View {
        NavigationStack(path: $store.scope(\.path, action: \.path)) {
            List {
                ForEach(searchResults) { character in
                    NavigationLink(state: RickMortyDetailFeature.State(character: character)) {
                        RickMortyListRowView(viewModel: character.viewModel)
                    }
                }
            }
            .onAppear {
                store.send(.loadCharacters)
            }
            .navigationTitle("Characters")
            .navigationBarTitleDisplayMode(.inline)
        } destination: { store in
            RickMortyDetailView(store: store)
        }
        .searchable(text: $store.searchText.sending(\.setSearchTerm))
    }

    var searchResults: [GetAllCharactersResponse.Character] {
        store.searchText.isEmpty ? store.characters : store.characters.filter { $0.name.contains(store.searchText) }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: Store(initialState: RickMortyListFeature.State()) {
            RickMortyListFeature()
        })
    }
}
