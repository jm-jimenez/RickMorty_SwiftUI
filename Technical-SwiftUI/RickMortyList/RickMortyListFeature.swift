//
//  RickMortyListFeature.swift
//  Technical-SwiftUI
//
//  Created by José María Jiménez  on 06/08/2026.
//

import ComposableArchitecture
import Combine

@Reducer
struct RickMortyListFeature {
    @ObservableState
    struct State: Equatable {
        var characters: [GetAllCharactersResponse.Character] = []
        var path = StackState<RickMortyDetailFeature.State>()
        var searchText = ""
    }
    
    enum Action {
        case loadCharacters
        case charactersLoaded(Result<GetAllCharactersResponse, Error>)
        case path(StackActionOf<RickMortyDetailFeature>)
        case setSearchTerm(String)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loadCharacters:
                return .run { send in
                    let networkClient = NetworkClient()
                    let result = await networkClient.getAllCharacters()
                    await send(.charactersLoaded(result))
                }
            case .charactersLoaded(.success(let output)):
                state.characters = output.results
                return .none
            case .charactersLoaded(.failure):
                return .none
            case .path:
                return .none
            case .setSearchTerm(let term):
                state.searchText = term
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            RickMortyDetailFeature()
        }
    }
}
