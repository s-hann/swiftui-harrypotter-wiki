//
//  Character.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 29/11/25.
//

import Foundation

struct Character: Identifiable, Hashable, Codable {
    let id: String
    let name: String
    let house: String?
    let species: String?
    let patronus: String?
    let born: String?
    let died: String?
    let image: URL?
    let wiki: URL?
}
