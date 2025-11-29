//
//  AppRoute.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 25/11/25.
//

enum AppRoute: Hashable {
    case books, characters, movies, potions, spells
    case bookDetails(book: Book)
    case characterDetails(character: Character)
    case movieDetails(movie: Movie)
    case potionDetails(potion: Potion)
    case spellDetails(spell: Spell)
}
