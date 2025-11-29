//
//  JsonAPI.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 29/11/25.
//

struct APIListResponse<T: Codable>: Codable {
    let data: [Resource<T>]
    let meta: MetaData?
    let links: Links?
}

struct APISingleResponse<T: Codable>: Codable {
    let data: Resource<T>
    let meta: MetaData?
    let links: Links?
}

struct Resource<T: Codable>: Identifiable, Codable {
    let id: String
    let type: String
    let attributes: T
}

struct MetaData: Codable {
    let pagination: Pagination?
}

struct Pagination: Codable {
    let current: Int
    let records: Int
}

struct Links: Codable {
    let next: String?
    let prev: String?
    let selfLink: String?
    
    enum CodingKeys: String, CodingKey {
        case next, prev, selfLink = "self"
    }
}
