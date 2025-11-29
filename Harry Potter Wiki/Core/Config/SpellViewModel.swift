//
//  SpellViewModel.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 29/11/25.
//

import Foundation

@Observable
class SpellViewModel {
    private let service: SpellService = .init()

    var listState: ViewState<[Spell]> = .idle
    var detailState: ViewState<Spell> = .idle

    private var currentPage = 1
    private var totalRecords = 0
    var isFetchingNextPage = false

    @MainActor
    func loadSpells() async {
        self.listState = .loading
        self.currentPage = 1

        do {
            let (spells, pagination) = try await service.fetchSpells(page: 1)
            self.totalRecords = pagination?.records ?? 0
            self.listState = .success(spells)
        } catch {
            self.listState = .failure(error.localizedDescription)
        }
    }

    @MainActor
    func loadNextPage() async {
        guard !isFetchingNextPage else { return }
        guard case .success(let currentSpells) = listState else { return }
        guard currentSpells.count < totalRecords else { return }

        self.isFetchingNextPage = true

        do {
            let nextPage = currentPage + 1
            let (newSpells, _) = try await service.fetchSpells(page: nextPage)
            self.currentPage = nextPage
            self.listState = .success(currentSpells + newSpells)
        } catch {
            print("Failed to load next page: \(error)")
        }

        self.isFetchingNextPage = false
    }

    @MainActor
    func loadSpellDetail(id: String) async {
        self.detailState = .loading

        do {
            let spell = try await service.fetchSpellDetail(id: id)
            self.detailState = .success(spell)
        } catch {
            self.detailState = .failure(error.localizedDescription)
        }
    }
}
