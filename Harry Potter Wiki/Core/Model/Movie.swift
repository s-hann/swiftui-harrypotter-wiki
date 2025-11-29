//
//  Movie.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 29/11/25.
//

import Foundation

struct Movie: Identifiable, Hashable, Codable {
    let id: String
    let title: String
    let summary: String
    let releaseDate: String?
    let rating: String?
    let runningTime: String?
    let budget: String?
    let boxOffice: String?
    let poster: URL?
    let trailer: URL?
}
