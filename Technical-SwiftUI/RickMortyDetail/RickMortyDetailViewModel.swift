//
//  RickMortyDetailViewModel.swift
//  Technical-SwiftUI
//
//  Created by José María Jiménez on 5/2/23.
//

import Foundation

class RickMortyDetailViewModel: ObservableObject {
    @Published var episodes: [EpisodeRowViewModel] = []
    lazy var infoViewModels: [InfoRowViewModel] = [
        InfoRowViewModel(key: "Species", value: character.species),
        InfoRowViewModel(key: "Gender", value: character.gender),
        InfoRowViewModel(key: "Status", value: character.status),
        InfoRowViewModel(key: "Location", value: character.location.name),
        InfoRowViewModel(key: "Origin", value: character.origin.name)
    ]

    private let networkClient = NetworkClient()
    private let character: GetAllCharactersResponse.Character

    init(character: GetAllCharactersResponse.Character) {
        self.character = character
    }

    func loadEpisodes() async {
        let episodesMap = character.episode.compactMap { $0.components(separatedBy: "/").last }
        let url = "https://rickandmortyapi.com/api/episode/" + episodesMap.joined(separator: ",")
        guard let url = URL(string: url) else { return }
        guard let (data, _) = try? await URLSession.shared.data(from: url) else { return }
        let result: [GetEpisodesResponse.Episode]
        switch episodes.count {
        case 1:
            result = handleSingleEpisode(data: data)
        default:
            result = handleMultipleEpisodes(data: data)
        }
        DispatchQueue.main.async {
            self.episodes = result.map(EpisodeRowViewModel.init)
        }
    }
}

private extension RickMortyDetailViewModel {
    func handleSingleEpisode(data: Data) -> [GetEpisodesResponse.Episode] {
        guard let result = try? JSONDecoder().decode(GetEpisodesResponse.Episode.self, from: data) else { return [] }
        return [result]
    }

    func handleMultipleEpisodes(data: Data) -> [GetEpisodesResponse.Episode] {
        guard let result = try? JSONDecoder().decode([GetEpisodesResponse.Episode].self, from: data) else { return [] }
        return result
    }
}
