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
                    case .movies:
                        MovieListView()
                    default:
                        Text("Not Implemented")
                    }
                }
        }
        .environment(router)
    }
}

#Preview {
    AppView()
}
