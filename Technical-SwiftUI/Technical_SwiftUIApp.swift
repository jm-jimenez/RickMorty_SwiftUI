//
//  Technical_SwiftUIApp.swift
//  Technical-SwiftUI
//
//  Created by José María Jiménez on 5/2/23.
//

import SwiftUI
import ComposableArchitecture

@main
struct Technical_SwiftUIApp: App {
    static let store = Store(initialState: RickMortyListFeature.State()) {
        RickMortyListFeature()
    }
    var body: some Scene {
        WindowGroup {
            ContentView(store: Self.store)
        }
    }
}
