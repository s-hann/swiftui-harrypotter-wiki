//
//  State.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 29/11/25.
//

enum ViewState<T> {
    case idle
    case loading
    case success(_ data: T)
    case failure(_ message: String)
}
