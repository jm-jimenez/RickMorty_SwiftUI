//
//  GetEpisodesResponse.swift
//  Technical-SwiftUI
//
//  Created by José María Jiménez on 5/2/23.
//

import Foundation

struct GetEpisodesResponse {
    struct Episode: Decodable {
        let id: Int
        let name: String
        let airDate: String
        let episode: String

        enum CodingKeys: String, CodingKey {
            case id, name, episode
            case airDate = "air_date"
        }
    }
}
