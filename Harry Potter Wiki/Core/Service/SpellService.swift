//
//  SpellService.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 29/11/25.
//

import Foundation

struct SpellAttributes: Codable {
    let name: String
    let incantation: String?
    let effect: String?
    let light: String?
    let image: URL?
    let wiki: URL?
}

struct SpellService {
    func fetchSpells(page: Int = 1) async throws -> (spells: [Spell], pagination: Pagination?) {
        let queryItems = [URLQueryItem(name: "page[number]", value: "\(page)")]
        let response: APIListResponse<SpellAttributes> = try await APIClient.fetch(path: "spells", queryItems: queryItems)

        let spells = response.data.map { resource in
            Spell(
                id: resource.id,
                name: resource.attributes.name,
                incantation: resource.attributes.incantation,
                effect: resource.attributes.effect,
                light: resource.attributes.light,
                image: resource.attributes.image,
                wiki: resource.attributes.wiki
            )
        }

        return (spells, response.meta?.pagination)
    }

    func fetchSpellDetail(id: String) async throws -> Spell {
        let response: APISingleResponse<SpellAttributes> = try await APIClient.fetch(path: "spells/\(id)")
        let r = response.data
        return Spell(
            id: r.id,
            name: r.attributes.name,
            incantation: r.attributes.incantation,
            effect: r.attributes.effect,
            light: r.attributes.light,
            image: r.attributes.image,
            wiki: r.attributes.wiki
        )
    }
}
