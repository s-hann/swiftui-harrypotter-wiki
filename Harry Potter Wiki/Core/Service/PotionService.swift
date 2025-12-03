//
//  PotionService.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 29/11/25.
//

import Foundation

struct PotionService {
    func fetchPotions(page: Int = 1) async throws -> (
        potions: [Potion], pagination: Pagination?
    ) {
        print("1")
        let queryItems = [URLQueryItem(name: "page[number]", value: "\(page)")]
        let response: APIListResponse<PotionAttributes> =
            try await APIClient.fetch(
                path: "potions",
                queryItems: queryItems
            )

        print("2")
        let potions = response.data.map { resource in
            Potion(
                id: resource.id,
                name: resource.attributes.name,
                effect: resource.attributes.effect,
                difficulty: resource.attributes.difficulty,
                ingredients: resource.attributes.ingredients,
                characteristics: resource.attributes.characteristics,
                sideEffects: resource.attributes.sideEffects,
                time: resource.attributes.time,
                inventors: resource.attributes.inventors,
                manufacturers: resource.attributes.manufacturers,
                image: resource.attributes.image,
                wiki: resource.attributes.wiki
            )
        }

        return (potions, response.meta?.pagination)
    }

    func fetchPotionDetail(id: String) async throws -> Potion {
        let response: APISingleResponse<PotionAttributes> =
            try await APIClient.fetch(path: "potions/\(id)")
        let resource = response.data
        return Potion(
            id: resource.id,
            name: resource.attributes.name,
            effect: resource.attributes.effect,
            difficulty: resource.attributes.difficulty,
            ingredients: resource.attributes.ingredients,
            characteristics: resource.attributes.characteristics,
            sideEffects: resource.attributes.sideEffects,
            time: resource.attributes.time,
            inventors: resource.attributes.inventors,
            manufacturers: resource.attributes.manufacturers,
            image: resource.attributes.image,
            wiki: resource.attributes.wiki
        )
    }
}
