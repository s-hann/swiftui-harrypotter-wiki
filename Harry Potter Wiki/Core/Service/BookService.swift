//
//  APIService.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 29/11/25.
//

import Foundation

struct BookService {
    func fetchBooks(page: Int = 1) async throws -> (
        books: [Book], pagination: Pagination?
    ) {
        let queryItems = [URLQueryItem(name: "page[number]", value: "\(page)")]

        let response: APIListResponse<BookAttributes> =
            try await APIClient.fetch(
                path: "books",
                queryItems: queryItems
            )

        let books = response.data.map { resource in
            Book(
                id: resource.id,
                title: resource.attributes.title,
                author: resource.attributes.author,
                summary: resource.attributes.summary,
                pages: resource.attributes.pages,
                releaseDate: resource.attributes.releaseDate,
                cover: resource.attributes.cover,
                wiki: resource.attributes.wiki
            )
        }

        return (books, response.meta?.pagination)
    }

    func fetchBookDetail(id: String) async throws -> Book {
        let response: APISingleResponse<BookAttributes> =
            try await APIClient.fetch(path: "books/\(id)")
        let resource = response.data
        return Book(
            id: resource.id,
            title: resource.attributes.title,
            author: resource.attributes.author,
            summary: resource.attributes.summary,
            pages: resource.attributes.pages,
            releaseDate: resource.attributes.releaseDate,
            cover: resource.attributes.cover,
            wiki: resource.attributes.wiki
        )
    }

    func fetchChapters(bookId: String) async throws -> [Chapter] {
        let response: APIListResponse<ChapterAttributes> =
            try await APIClient.fetch(path: "books/\(bookId)/chapters")

        return response.data
            .map {
                Chapter(
                    id: $0.id,
                    title: $0.attributes.title,
                    order: $0.attributes.order ?? 0
                )
            }
            .sorted { $0.order < $1.order }
    }
}
