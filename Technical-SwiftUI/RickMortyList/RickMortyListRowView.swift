//
//  RickMortyListRowView.swift
//  Technical-SwiftUI
//
//  Created by José María Jiménez on 5/2/23.
//

import SwiftUI

struct RickMortyListRowView: View {
    let viewModel: RickMortyListRowViewModel
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: viewModel.url)) { image in
                image
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
            }

            VStack(alignment: .leading) {
                Text(viewModel.name)
                    .font(.headline)
                Text("Episodes: \(viewModel.episodes)")
                    .font(.subheadline)
            }

            Spacer()

            VStack(alignment: .trailing) {
                Text(viewModel.species)
                Text(viewModel.gender)
            }
            .font(.body)
            .foregroundColor(.secondary)
        }
        .padding(.horizontal)
    }
}

struct RickMortyListRowViewModel: Identifiable {
    var id: Int
    let url: String
    let name: String
    let episodes: Int
    let species: String
    let gender: String

    static let sample = RickMortyListRowViewModel(id: 1, url: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", name: "Rick Sanchez", episodes: 3, species: "Human", gender: "Male")

}

struct RickMortyListRowView_Previews: PreviewProvider {
    static var previews: some View {
        RickMortyListRowView(viewModel: RickMortyListRowViewModel.sample)
    }
}
