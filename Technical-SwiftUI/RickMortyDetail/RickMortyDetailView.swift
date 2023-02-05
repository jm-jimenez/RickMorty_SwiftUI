//
//  RickMortyDetailView.swift
//  Technical-SwiftUI
//
//  Created by José María Jiménez on 5/2/23.
//

import SwiftUI

struct RickMortyDetailView: View {

    let character: GetAllCharactersResponse.Character

    @StateObject private var viewModel: RickMortyDetailViewModel

    init(character: GetAllCharactersResponse.Character) {
        self.character = character
        _viewModel = .init(wrappedValue: RickMortyDetailViewModel(character: character))
    }
    
    var body: some View {
        List {
            HeaderView(character: character)

            Section("info") {
                ForEach(viewModel.infoViewModels) { viewModel in
                    InfoRowView(viewModel: viewModel)
                }
            }

            if viewModel.episodes.count > 0 {
                Section("Episodes") {
                    ForEach(viewModel.episodes) { viewModel in
                        EpisodeRowView(viewModel: viewModel)
                    }
                }
            }
        }
        .task {
            await viewModel.loadEpisodes()
        }
    }
}

struct RickMortyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RickMortyDetailView(character: GetAllCharactersResponse.Character.sample)
    }
}
