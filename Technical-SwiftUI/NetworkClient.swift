//
//  NetworkClient.swift
//  Technical-SwiftUI
//
//  Created by José María Jiménez on 5/2/23.
//

import Foundation
import Dependencies

struct NetworkClient: Sendable {
    var getAllCharacters: @Sendable () async -> Result<GetAllCharactersResponse, Error>
    var getEpisodes: @Sendable ([String]) async -> Result<Data, Error>

    enum NetworkError: Error {
        case badUrl
    }
}

extension NetworkClient: DependencyKey {
    static let liveValue = NetworkClient (
        getAllCharacters: {
            guard let url = URL(string: "https://rickandmortyapi.com/api/character") else { return .failure(NetworkError.badUrl)}
            do {
                let data = try await URLSession.shared.data(from: url).0
                let result = try JSONDecoder().decode(GetAllCharactersResponse.self, from: data)
                return .success(result)
            } catch {
                return .failure(error)
            }
        },
        getEpisodes: { episodes in
            let episodesMap = episodes.compactMap { $0.components(separatedBy: "/").last }
            let url = "https://rickandmortyapi.com/api/episode/" + episodesMap.joined(separator: ",")
            
            guard let url = URL(string: url) else { return .failure(NetworkError.badUrl)}
            do {
                let data = try await URLSession.shared.data(from: url).0
                return .success(data)
            } catch {
                return .failure(error)
            }
        })
}

extension DependencyValues {
    var networkClient: NetworkClient {
        get {
            self[NetworkClient.self]
        }
        set {
            self[NetworkClient.self] = newValue
        }
    }
}
