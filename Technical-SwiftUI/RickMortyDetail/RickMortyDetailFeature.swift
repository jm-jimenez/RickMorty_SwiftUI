//
//  RickMortyDetailFeature.swift
//  Technical-SwiftUI
//
//  Created by José María Jiménez  on 06/08/2026.
//

import ComposableArchitecture
import Foundation

@Reducer
struct RickMortyDetailFeature {
    
    @ObservableState
    struct State: Equatable {
        let character: GetAllCharactersResponse.Character
        
        var infoViewModels: [InfoRowViewModel] {
            [
                InfoRowViewModel(key: "Species", value: character.species),
                InfoRowViewModel(key: "Gender", value: character.gender),
                InfoRowViewModel(key: "Status", value: character.status),
                InfoRowViewModel(key: "Location", value: character.location.name),
                InfoRowViewModel(key: "Origin", value: character.origin.name)
            ]
        }
        
        var episodes: [EpisodeRowViewModel] = []
    }
    
    enum Action{
        case loadEpisodes
        case episodesLoaded([EpisodeRowViewModel])
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loadEpisodes:
                    return .run { [episodes = state.character.episode] send in
                        let episodesMap = episodes.compactMap { $0.components(separatedBy: "/").last }
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
                        await send(.episodesLoaded(result.map(EpisodeRowViewModel.init)))
                    }
            case .episodesLoaded(let episodes):
                state.episodes = episodes
                return .none
            }
        }
    }
}

extension RickMortyDetailFeature {
    func handleSingleEpisode(data: Data) -> [GetEpisodesResponse.Episode] {
        guard let result = try? JSONDecoder().decode(GetEpisodesResponse.Episode.self, from: data) else { return [] }
        return [result]
    }

    func handleMultipleEpisodes(data: Data) -> [GetEpisodesResponse.Episode] {
        guard let result = try? JSONDecoder().decode([GetEpisodesResponse.Episode].self, from: data) else { return [] }
        return result
    }
}
