//
//  PotionAttributes.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 02/12/25.
//

import Foundation

struct PotionAttributes: Codable {
    let name: String
    let effect: String?
    let difficulty: String?
    let ingredients: String?
    let characteristics: String?
    let sideEffects: String?
    let time: String?
    let inventors: String?
    let manufacturers: String?
    let image: URL?
    let wiki: URL?
}
