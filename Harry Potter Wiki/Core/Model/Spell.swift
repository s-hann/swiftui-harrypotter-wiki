//
//  Spell.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 29/11/25.
//

import Foundation

struct Spell: Identifiable, Hashable, Codable {
    let id: String
    let name: String
    let incantation: String?
    let effect: String?
    let light: String?
    let image: URL?
    let wiki: URL?
}

extension Spell {
    static let dummySpell: Spell = .init(
        id: "0a1b2c3d-4e5f-6789-abcd-ef0123456789",
        name: "Expelliarmus",
        incantation: "Expelliarmus",
        effect: "Disarms the target",
        light: "Red",
        image: URL(string: "https://example.com/expelliarmus.png"),
        wiki: URL(string: "https://harrypotter.fandom.com/wiki/Disarming_Charm")
    )
}
