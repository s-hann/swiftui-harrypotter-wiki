//
//  PotionViewModel.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 29/11/25.
//

import Foundation

@Observable
class PotionViewModel {
    private let service: PotionService = .init()

    var listState: ViewState<[Potion]> = .idle
    var detailState: ViewState<Potion> = .idle

    private var currentPage = 1
    private var totalRecords = 0
    var isFetchingNextPage = false

    @MainActor
    func loadPotions() async {
        self.listState = .loading
        self.currentPage = 1

        do {
            print("vm 1")
            let (potions, pagination) = try await service.fetchPotions(page: 1)
            self.totalRecords = pagination?.records ?? 0
            print("vm 2")
            self.listState = .success(potions)
        } catch {
            print("vm 3 \(error)")
            self.listState = .failure(error.localizedDescription)
        }
    }

    @MainActor
    func loadNextPage() async {
        guard !isFetchingNextPage else { return }
        guard case .success(let currentPotions) = listState else { return }
        guard currentPotions.count < totalRecords else { return }

        self.isFetchingNextPage = true

        do {
            let nextPage = currentPage + 1
            let (newPotions, _) = try await service.fetchPotions(page: nextPage)
            self.currentPage = nextPage
            self.listState = .success(currentPotions + newPotions)
        } catch {
            print("Failed to load next page: \(error)")
        }

        self.isFetchingNextPage = false
    }

    @MainActor
    func loadPotionDetail(id: String) async {
        self.detailState = .loading

        do {
            let potion = try await service.fetchPotionDetail(id: id)
            self.detailState = .success(potion)
        } catch {
            self.detailState = .failure(error.localizedDescription)
        }
    }
}
