//
//  AppRoute.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 25/11/25.
//

enum AppRoute: Hashable {
    case books, characters, movies, potions, spells
    case bookDetails(bookId: Book)
    case characterDetails(characterId: Character)
    case movieDetails(movieId: Movie)
    case potionDetails(potionId: String)
    case spellDetails(spellId: String)
}
