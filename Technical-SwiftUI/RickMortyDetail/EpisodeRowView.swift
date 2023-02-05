//
//  EpisodeRowView.swift
//  Technical-SwiftUI
//
//  Created by José María Jiménez on 5/2/23.
//

import SwiftUI

struct EpisodeRowViewModel: Identifiable {
    let id = UUID()
    let name: String
    let episode: String
    let airDate: String

    init(name: String, episode: String, airDate: String) {
        self.name = name
        self.episode = episode
        self.airDate = airDate
    }

    init(episode: GetEpisodesResponse.Episode) {
        name = episode.name
        self.episode = episode.episode
        airDate = episode.airDate
    }

    static let sample = EpisodeRowViewModel(name: "Test", episode: "Test", airDate: "Test")
}

struct EpisodeRowView: View {
    let viewModel: EpisodeRowViewModel

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(viewModel.name)
                    .font(.headline)
                Text(viewModel.airDate)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Text(viewModel.episode)
                .font(.body)
        }
        .padding(.horizontal)
    }
}

struct EpisodeRowView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeRowView(viewModel: .sample)
    }
}
