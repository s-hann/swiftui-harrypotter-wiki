//
//  MovieListView.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 29/11/25.
//

import SwiftUI

struct MovieListView: View {
    @Environment(Router.self) private var router
    @State private var vm: MovieViewModel = .init()

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
    ]

    var body: some View {
        Group {
            switch vm.listState {
            case .idle:
                Color.clear
            case .loading:
                ProgressView("Loading...")
            case .success(let movies):
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(movies) { movie in
                            GridItemView(
                                title: movie.title,
                                image: movie.poster,
                                action: {
                                    router.navigateTo(
                                        route: .movieDetails(movie: movie)
                                    )
                                }
                            )
                        }
                        Color.clear
                            .frame(height: 20)
                            .onAppear {
                                Task { await vm.loadNextPage() }
                            }

                        if vm.isFetchingNextPage {
                            ProgressView()
                        }
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal)
                }
            case .failure(let message):
                ContentUnavailableView(
                    "Error",
                    systemImage: "xmark",
                    description: Text(message)
                )
            }
        }
        .navigationTitle("Movies")
        .task {
            if case .idle = vm.listState {
                await vm.loadMovies()
            }
        }
    }
}
