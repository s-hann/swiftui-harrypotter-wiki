//
//  BookViewModel.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 29/11/25.
//

import Foundation

@Observable
class BookViewModel {
    private let service: BookService = .init()

    var listState: ViewState<[Book]> = .idle
    var detailState: ViewState<Book> = .idle
    var chaptersState: ViewState<[Chapter]> = .idle

    private var currentPage = 1
    private var totalRecords = 0
    var isFetchingNextPage = false

    @MainActor
    func loadBooks() async {
        self.listState = .loading
        self.currentPage = 1

        do {
            let (books, pagination) = try await service.fetchBooks(page: 1)
            self.totalRecords = pagination?.records ?? 0
            self.listState = .success(books)
        } catch {
            self.listState = .failure(error.localizedDescription)
        }
    }

    @MainActor
    func loadNextPage() async {
        guard !isFetchingNextPage else { return }

        guard case .success(let currentBooks) = listState else { return }

        guard currentBooks.count < totalRecords else { return }

        self.isFetchingNextPage = true

        do {
            let nextPage = currentPage + 1
            let (newBooks, _) = try await service.fetchBooks(page: nextPage)

            self.currentPage = nextPage

            self.listState = .success(currentBooks + newBooks)
        } catch {
            print("Failed to load next page: \(error)")
        }

        self.isFetchingNextPage = false
    }

    @MainActor
    func loadBookDetail(id: String) async {
        self.detailState = .loading
        self.chaptersState = .idle

        do {
            let book = try await service.fetchBookDetail(id: id)
            self.detailState = .success(book)
        } catch {
            self.detailState = .failure(error.localizedDescription)
        }
    }

    @MainActor
    func loadChapters(bookId: String) async {
        self.chaptersState = .loading
        do {
            let chapters = try await service.fetchChapters(bookId: bookId)
            self.chaptersState = .success(chapters)
        } catch {
            self.chaptersState = .failure(error.localizedDescription)
        }
    }
}
