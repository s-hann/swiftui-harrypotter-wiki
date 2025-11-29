//
//  MovieViewModel.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 29/11/25.
//

import Foundation

@Observable
class MovieViewModel {

    var listState: ViewState<[Movie]> = .idle
    var detailState: ViewState<Movie> = .idle

    // Pagination
    private var currentPage = 1
    private var totalRecords = 0
    var isFetchingNextPage = false

    private let service = MovieService()

    @MainActor
    func loadMovies() async {
        self.listState = .loading
        self.currentPage = 1

        do {
            let (movies, pagination) = try await service.fetchMovies(page: 1)
            self.totalRecords = pagination?.records ?? 0
            self.listState = .success(movies)
        } catch {
            self.listState = .failure(error.localizedDescription)
        }
    }

    @MainActor
    func loadNextPage() async {
        guard !isFetchingNextPage else { return }
        guard case .success(let currentMovies) = listState else { return }

        if totalRecords > 0 && currentMovies.count >= totalRecords { return }

        self.isFetchingNextPage = true
        do {
            let nextPage = currentPage + 1
            let (newMovies, _) = try await service.fetchMovies(page: nextPage)

            if !newMovies.isEmpty {
                self.currentPage = nextPage
                self.listState = .success(currentMovies + newMovies)
            }
        } catch {
            print("Pagination error: \(error)")
        }
        self.isFetchingNextPage = false
    }

    @MainActor
    func loadMovieDetail(id: String) async {
        self.detailState = .loading
        do {
            let movie = try await service.fetchMovieDetail(id: id)
            self.detailState = .success(movie)
        } catch {
            self.detailState = .failure(error.localizedDescription)
        }
    }
}
