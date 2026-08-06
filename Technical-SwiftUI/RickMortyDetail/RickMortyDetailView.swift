//
//  RickMortyDetailView.swift
//  Technical-SwiftUI
//
//  Created by José María Jiménez on 5/2/23.
//

import SwiftUI
import ComposableArchitecture

struct RickMortyDetailView: View {

    let store: StoreOf<RickMortyDetailFeature>
    
    var body: some View {
        List {
            HeaderView(character: store.character)

            Section("info") {
                ForEach(store.infoViewModels) { viewModel in
                    InfoRowView(viewModel: viewModel)
                }
            }

            if store.episodes.count > 0 {
                Section("Episodes") {
                    ForEach(store.episodes) { viewModel in
                        EpisodeRowView(viewModel: viewModel)
                    }
                }
            }
        }
        .task {
            store.send(.loadEpisodes)
        }
    }
}

struct RickMortyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RickMortyDetailView(store: Store(initialState: RickMortyDetailFeature.State(character: GetAllCharactersResponse.Character.dummy())){
            RickMortyDetailFeature()
        })
    }
}

private extension GetAllCharactersResponse.Character {
    static func dummy() -> Self {
        Self(id: 0,
             name: "test",
             status: "test",
             species: "test",
             type: "test",
             gender: "test",
             origin: Origin(name: "test", url: "test"),
             location: Location(name: "test", url: "test"),
             image: "test",
             episode: ["test"],
             url: "test",
             created: "test")
    }
}
