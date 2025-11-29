//
//  CharacterViewModel.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 25/11/25.
//

import Foundation

@Observable
class CharacterViewModel {
    private let service: CharacterService = .init()
    
    var listState: ViewState<[Character]> = .idle
    var detailState: ViewState<Character> = .idle
    
    // Sort
    var selectedSort: SortOption = .default
    
    // Pagination
    private var currentPage = 1
    private var totalRecords = 0
    var isFetchingNextPage = false
    
    @MainActor
    func loadCharacters() async {
        self.listState = .loading
        self.currentPage = 1
        
        do {
            // Pass the selected sort option
            let (chars, pagination) = try await service.fetchCharacters(page: 1, sort: selectedSort.apiValue)
            self.totalRecords = pagination?.records ?? 0
            self.listState = .success(chars)
        } catch {
            self.listState = .failure(error.localizedDescription)
        }
    }
    
    @MainActor
    func loadNextPage() async {
        guard !isFetchingNextPage else { return }
        guard case .success(let currentChars) = listState else { return }
        
        if totalRecords > 0 && currentChars.count >= totalRecords { return }
        
        self.isFetchingNextPage = true
        do {
            let nextPage = currentPage + 1
            let (newChars, _) = try await service.fetchCharacters(page: nextPage, sort: selectedSort.apiValue)
            
            if !newChars.isEmpty {
                self.currentPage = nextPage
                self.listState = .success(currentChars + newChars)
            }
        } catch {
            print("Pagination error: \(error)")
        }
        self.isFetchingNextPage = false
    }
    
    @MainActor
    func loadCharacterDetail(id: String) async {
        self.detailState = .loading
        do {
            let char = try await service.fetchCharacterDetail(id: id)
            self.detailState = .success(char)
        } catch {
            self.detailState = .failure(error.localizedDescription)
        }
    }
}
