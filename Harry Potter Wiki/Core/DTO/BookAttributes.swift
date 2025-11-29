//
//  BookAttributes.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 29/11/25.
//

import Foundation

struct BookAttributes: Codable {
    let title: String
    let author: String?
    let summary: String?
    let pages: Int?
    let releaseDate: String?
    let cover: URL?
    let wiki: URL?
}
