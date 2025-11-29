//
//  PotionService.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 29/11/25.
//

import Foundation

struct PotionAttributes: Codable {
    let name: String
    let effect: String?
    let ingredients: [String]?
    let difficulty: String?
    let image: URL?
    let wiki: URL?
}

struct PotionService {
    func fetchPotions(page: Int = 1) async throws -> (potions: [Potion], pagination: Pagination?) {
        let queryItems = [URLQueryItem(name: "page[number]", value: "\(page)")]
        let response: APIListResponse<PotionAttributes> = try await APIClient.fetch(path: "potions", queryItems: queryItems)

        let potions = response.data.map { resource in
            Potion(
                id: resource.id,
                name: resource.attributes.name,
                effect: resource.attributes.effect,
                ingredients: resource.attributes.ingredients,
                difficulty: resource.attributes.difficulty,
                image: resource.attributes.image,
                wiki: resource.attributes.wiki
            )
        }

        return (potions, response.meta?.pagination)
    }

    func fetchPotionDetail(id: String) async throws -> Potion {
        let response: APISingleResponse<PotionAttributes> = try await APIClient.fetch(path: "potions/\(id)")
        let r = response.data
        return Potion(
            id: r.id,
            name: r.attributes.name,
            effect: r.attributes.effect,
            ingredients: r.attributes.ingredients,
            difficulty: r.attributes.difficulty,
            image: r.attributes.image,
            wiki: r.attributes.wiki
        )
    }
}
