//
//  MovieService.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 29/11/25.
//

import Foundation

struct MovieService {
    func fetchMovies(page: Int = 1, pageSize: Int = 15) async throws -> (
        movies: [Movie], pagination: Pagination?
    ) {
        let queryItems = [
            URLQueryItem(name: "page[number]", value: "\(page)"),
            URLQueryItem(name: "page[size]", value: "\(pageSize)"),
        ]

        let response: APIListResponse<MovieAttributes> =
            try await APIClient.fetch(
                path: "movies",
                queryItems: queryItems
            )

        let movies = response.data.map { resource in
            Movie(
                id: resource.id,
                title: resource.attributes.title,
                summary: resource.attributes.summary,
                releaseDate: resource.attributes.releaseDate,
                rating: resource.attributes.rating,
                runningTime: resource.attributes.runningTime,
                budget: resource.attributes.budget,
                boxOffice: resource.attributes.boxOffice,
                poster: resource.attributes.poster,
                trailer: resource.attributes.trailer
            )
        }

        return (movies, response.meta?.pagination)
    }

    func fetchMovieDetail(id: String) async throws -> Movie {
        let response: APISingleResponse<MovieAttributes> =
            try await APIClient.fetch(path: "movies/\(id)")
        let resource = response.data
        return Movie(
            id: resource.id,
            title: resource.attributes.title,
            summary: resource.attributes.summary,
            releaseDate: resource.attributes.releaseDate,
            rating: resource.attributes.rating,
            runningTime: resource.attributes.runningTime,
            budget: resource.attributes.budget,
            boxOffice: resource.attributes.boxOffice,
            poster: resource.attributes.poster,
            trailer: resource.attributes.trailer
        )
    }
}
