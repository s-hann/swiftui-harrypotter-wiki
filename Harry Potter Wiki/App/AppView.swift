//
//  AppView.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 25/11/25.
//

import SwiftUI

struct AppView: View {
    @State private var router: Router = .init()

    var body: some View {
        NavigationStack(path: $router.path) {
            HomeView()
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .books:
                        BookListView()
                    case .bookDetails(let book):
                        BookDetailView(book: book)
                    case .characters:
                        CharacterListView()
                    case .characterDetails(let character):
                        CharacterDetailView(character: character)
                    case .movies:
                        MovieListView()
                    case .movieDetails(let movie):
                        MovieDetailView(movie: movie)
                    case .potions:
                        PotionListView()
                    case .potionDetails(let potion):
                        PotionDetailView(potion: potion)
                    case .spells:
                        SpellListView()
                    case .spellDetails(let spell):
                        SpellDetailView(spell: spell)
//                    default:
//                        Text("Not Implemented")
                    }
                }
        }
        .environment(router)
    }
}

#Preview {
    AppView()
}
