//
//  RickMortyDetailFeatureTests.swift
//  Technical-SwiftUI
//
//  Created by José María Jiménez  on 06/08/2026.
//

import ComposableArchitecture
import Testing

@testable import Technical_SwiftUI
import Foundation

@MainActor
struct RickMortyDetailFeatureTests {
    
    @Test
    func loadEpisodes() async {
        let store = TestStore(initialState: RickMortyDetailFeature.State(character: .dummy(episode: ["1", "2"]))) {
            RickMortyDetailFeature()
        } withDependencies: {
            $0.networkClient.getEpisodes = { episodes in
                let mockEpisodes: [GetEpisodesResponse.Episode] = [.dummy(), .dummy()]
                let data = try! JSONEncoder().encode(mockEpisodes)
                return .success(data)
            }
        }
        
        await store.send(.loadEpisodes)
        
        await store.receive(\.episodesLoaded) {
            $0.episodes = [.dummy() ]
        }
    }
}

extension GetEpisodesResponse.Episode {
    static func dummy() -> Self {
        Self(id: 0,
             name: "test",
             airDate: "test",
             episode: "test")
    }
}
