//
//  APIService.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 29/11/25.
//

import Foundation

struct CharacterService {
    func fetchCharacters(page: Int = 1, pageSize: Int = 15, sort: String? = nil)
        async throws -> (characters: [Character], pagination: Pagination?)
    {
        var queryItems = [
            URLQueryItem(name: "page[number]", value: "\(page)"),
            URLQueryItem(name: "page[size]", value: "\(pageSize)"),
        ]

        if let sort = sort {
            queryItems.append(URLQueryItem(name: "sort", value: sort))
        }

        let response: APIListResponse<CharacterAttributes> =
            try await APIClient.fetch(
                path: "characters",
                queryItems: queryItems
            )

        let characters = response.data.map { resource in
            Character(
                id: resource.id,
                name: resource.attributes.name,
                house: resource.attributes.house,
                species: resource.attributes.species,
                patronus: resource.attributes.patronus,
                born: resource.attributes.born,
                died: resource.attributes.died,
                image: resource.attributes.image,
                wiki: resource.attributes.wiki
            )
        }

        return (characters, response.meta?.pagination)
    }

    func fetchCharacterDetail(id: String) async throws -> Character {
        let response: APISingleResponse<CharacterAttributes> =
            try await APIClient.fetch(path: "characters/\(id)")
        let resource = response.data
        return Character(
            id: resource.id,
            name: resource.attributes.name,
            house: resource.attributes.house,
            species: resource.attributes.species,
            patronus: resource.attributes.patronus,
            born: resource.attributes.born,
            died: resource.attributes.died,
            image: resource.attributes.image,
            wiki: resource.attributes.wiki
        )
    }
}
