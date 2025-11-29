//
//  CharacterAttributes.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 29/11/25.
//

import Foundation

struct CharacterAttributes: Codable {
    let name: String
    let house: String?
    let image: URL?
    let species: String?
    let patronus: String?
    let born: String?
    let died: String?
    let wiki: URL?
}
