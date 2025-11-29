//
//  SortOption.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 29/11/25.
//

enum SortOption: String, CaseIterable, Identifiable {
    case `default` = "Default"
    case nameAscending = "Name (A-Z)"
    case nameDescending = "Name (Z-A)"

    var id: String { rawValue }

    var apiValue: String? {
        switch self {
        case .default: return nil
        case .nameAscending: return "name"
        case .nameDescending: return "-name"
        }
    }
}
