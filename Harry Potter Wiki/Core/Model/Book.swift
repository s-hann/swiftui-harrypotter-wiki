//
//  Book.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 29/11/25.
//

import Foundation

struct Book: Identifiable, Hashable, Codable {
    let id: String
    let title: String
    let author: String?
    let summary: String?
    let pages: Int?
    let releaseDate: String?
    let cover: URL?
    let wiki: URL?
}

extension Book {
    static let dummyBook: Book = .init(
        id: "76040954-a2ea-45bc-a058-6d2d9f6d71ea",
        title:
            "Harry Potter and the Philosopher's Stone",
        author: "J. K. Rowling",
        summary:
            "Harry Potter has never even heard of Hogwarts when the letters start dropping on the doormat at number four, Privet Drive.",
        pages: 223,
        releaseDate: "1997-06-26",
        cover: URL(
            string:
                "https://www.wizardingworld.com/images/products/books/photographic/JKR_PhilosophersStone_Book_Cover.png"
        ),
        wiki: URL(
            string:
                "https://harrypotter.fandom.com/wiki/Harry_Potter_and_the_Philosopher%27s_Stone"
        )
    )
}
