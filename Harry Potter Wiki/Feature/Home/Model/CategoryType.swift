//
//  HomeCategory.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 25/11/25.
//

import SwiftUI

struct CategoryProperties: Identifiable {
    let id: UUID = .init()
    let route: AppRoute
    let label: String
    let icon: String
    var color: Color = .blue
}

enum CategoryType: CaseIterable {
    case books, characters, movies, potions, spells

    var properties: CategoryProperties {
        switch self {
        case .books:
            return .init(
                route: .books,
                label: "Books",
                icon: "book",
                color: .blue
            )
        case .characters:
            return .init(
                route: .characters,
                label: "Characters",
                icon: "person.2",
                color: .red
            )
        case .movies:
            return .init(
                route: .movies,
                label: "Movies",
                icon: "film",
                color: .teal
            )
        case .potions:
            return .init(
                route: .potions,
                label: "Potions",
                icon: "flask",
                color: .indigo
            )
        case .spells:
            return .init(
                route: .spells,
                label: "Spells",
                icon: "wand.and.sparkles",
                color: .brown
            )
        }
    }
}
