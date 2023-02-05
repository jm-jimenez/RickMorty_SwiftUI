//
//  RickMortyListViewModel.swift
//  Technical-SwiftUI
//
//  Created by José María Jiménez on 5/2/23.
//

import Foundation
import Combine

class RickMortyListViewModel: ObservableObject {

    @Published var viewModels: [RickMortyListRowViewModel] = []
    private var characters: [GetAllCharactersResponse.Character] = []
    private let networkClient = NetworkClient()
    private var subscriptions: Set<AnyCancellable> = []


    func loadCharacters() {
        networkClient.getAllCharacters()
            .receive(on: RunLoop.main)
            .map { output in
                self.characters = output.results
                let viewModels = output.results.map {
                    RickMortyListRowViewModel(id: $0.id, url: $0.image, name: $0.name, episodes: $0.episode.count, species: $0.species, gender: $0.gender)
                }
                return viewModels
            }
            .sink { _ in

            } receiveValue: { viewModels in
                self.viewModels = viewModels
            }
            .store(in: &subscriptions)
    }

    func getCharacterForViewModel(_ viewModel: RickMortyListRowViewModel) -> GetAllCharactersResponse.Character {
        characters.first(where: { $0.id == viewModel.id })!
    }
}
