//
//  GetAllCharactersResponse.swift
//  Technical-SwiftUI
//
//  Created by José María Jiménez on 5/2/23.
//

struct GetAllCharactersResponse: Decodable {
    let info: Info
    let results: [Character]

    struct Info: Decodable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }

    struct Character: Decodable {
        let id: Int
        let name: String
        let status: String
        let species: String
        let type: String
        let gender: String
        let origin: Origin
        let location: Location
        let image: String
        let episode: [String]
        let url: String
        let created: String

        struct Origin: Decodable {
            let name: String
            let url: String
        }

        struct Location: Decodable {
            let name: String
            let url: String
        }

        static let sample = Character(id: 1, name: "Rick", status: "Alive", species: "Human", type: "", gender: "Male", origin: .init(name: "Earth", url: ""), location: .init(name: "", url: ""), image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", episode: [
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/2"], url: "https://rickandmortyapi.com/api/character/1", created: "2017-11-04T18:48:46.250Z")
    }
}
