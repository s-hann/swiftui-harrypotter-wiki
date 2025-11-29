//
//  MovieListView.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 29/11/25.
//

import SwiftUI

struct MovieListView: View {
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
                            MoviePosterView(movie: movie)
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

struct MoviePosterView: View {
    let movie: Movie

    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: movie.poster) { img in
                img.resizable().scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .clipped()
            .cornerRadius(8)

            Text(movie.title)
                .font(.headline)
                .lineLimit(2)
                .multilineTextAlignment(.leading)

            if let date = movie.releaseDate {
                Text(date)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
