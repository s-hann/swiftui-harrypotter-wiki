//
//  CharacterListView.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 25/11/25.
//

import SwiftUI

struct CharacterListView: View {
    @Environment(Router.self) private var router
    @State private var vm: CharacterViewModel = .init()

    var body: some View {
        Group {
            switch vm.listState {
            case .idle:
                Color.clear
            case .loading:
                ProgressView("Loading...")
            case .success(let characters):
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(characters) { character in
                            ListItemView(
                                title: character.name,
                                image: character.image,
                                action: {
                                    router.navigateTo(
                                        route: .characterDetails(
                                            character: character
                                        )
                                    )
                                }
                            )
                        }
                        Color.clear
                            .frame(height: 20)
                            .onAppear {
                                Task { await vm.loadNextPage() }
                            }

                        if vm.isFetchingNextPage {
                            ProgressView().padding()
                        }
                    }
                    .padding(.horizontal)
                }
            case .failure(let message):
                ContentUnavailableView(
                    "Error",
                    systemImage: "xmark",
                    description: Text(message)
                )
            }
        }
        .navigationTitle(Text("Character List"))
        .task {
            if case .idle = vm.listState {
                await vm.loadCharacters()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $vm.selectedSort) {
                        ForEach(SortOption.allCases) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                }
            }
        }
        .onChange(of: vm.selectedSort) {
            Task { await vm.loadCharacters() }
        }
    }
}

#Preview {
    CharacterListView()
}
