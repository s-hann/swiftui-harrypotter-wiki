//
//  HomeViewModel.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 03/12/25.
//

import Foundation

@Observable
class HomeViewModel {
    private let service: BookService = .init()

    var listState: ViewState<[Book]> = .idle

    @MainActor
    func loadBooks() async {
        self.listState = .loading

        do {
            let books = try await service.fetchFeaturedBooks()
            self.listState = .success(books)
        } catch {
            self.listState = .failure(error.localizedDescription)
        }
    }
}
