//
//  NetworkClient.swift
//  Technical-SwiftUI
//
//  Created by José María Jiménez on 5/2/23.
//

import Foundation
import Combine

struct NetworkClient {
    func getAllCharacters() -> AnyPublisher<GetAllCharactersResponse, Error> {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else { return Fail(error: NetworkError.badUrl).eraseToAnyPublisher() }
        return URLSession.shared.dataTaskPublisher(for: url).map { $0.data }
            .decode(type: GetAllCharactersResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    enum NetworkError: Error {
        case badUrl
    }
}
