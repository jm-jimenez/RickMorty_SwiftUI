//
//  HeaderView.swift
//  Technical-SwiftUI
//
//  Created by José María Jiménez on 5/2/23.
//

import SwiftUI

struct HeaderView: View {
    let character: GetAllCharactersResponse.Character
    var body: some View {
        HStack {
            Spacer()
            VStack {
                AsyncImage(url: URL(string: character.image)) { image in
                    image
                        .resizable()
                        .frame(width: 125, height: 125)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                }
                .overlay(Circle().stroke(lineWidth: 2))
                .foregroundColor(.white)

                .shadow(radius: 6)

                Text(character.name)
                    .font(.title)
                    .padding(.top)
            }
            Spacer()
        }
        .padding(.vertical)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(character: .sample)
    }
}
