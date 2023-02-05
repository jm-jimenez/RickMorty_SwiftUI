//
//  InfoRowView.swift
//  Technical-SwiftUI
//
//  Created by José María Jiménez on 5/2/23.
//

import SwiftUI

struct InfoRowViewModel: Identifiable {
    let id = UUID()
    let key: String
    let value: String

    static let sample = InfoRowViewModel(key: "Test", value: "Test")
}

struct InfoRowView: View {

    let viewModel: InfoRowViewModel

    var body: some View {
        HStack(alignment: .top) {
            Text(viewModel.key)
            Spacer()
            Text(viewModel.value)
                .multilineTextAlignment(.trailing)
                .foregroundColor(.secondary)
        }
        .font(.body)
        .padding(.horizontal)
    }
}

struct InfoRowView_Previews: PreviewProvider {
    static var previews: some View {
        InfoRowView(viewModel: .sample)
    }
}
