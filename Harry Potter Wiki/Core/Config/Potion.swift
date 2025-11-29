//
//  Potion.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 29/11/25.
//

import Foundation

struct Potion: Identifiable, Hashable, Codable {
    let id: String
    let name: String
    let effect: String?
    let ingredients: [String]?
    let difficulty: String?
    let image: URL?
    let wiki: URL?
}

extension Potion {
    static let dummyPotion: Potion = .init(
        id: "c9b6c1f8-1c2d-4a7d-9a2f-1e2a3b4c5d6e",
        name: "Polyjuice Potion",
        effect: "Allows the drinker to assume the form of someone else",
        ingredients: ["Lacewing flies", "Leeches", "Powdered bicorn horn", "Knotgrass", "Fluxweed", "Boomslang skin"],
        difficulty: "Advanced",
        image: URL(string: "https://example.com/polyjuice.png"),
        wiki: URL(string: "https://harrypotter.fandom.com/wiki/Polyjuice_Potion")
    )
}
