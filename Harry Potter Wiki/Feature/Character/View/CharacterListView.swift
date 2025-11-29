//
//  CharacterListView.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 25/11/25.
//

import SwiftUI

struct CharacterListView: View {
    @State private var vm: CharacterViewModel = .init()

    var body: some View {
        ScrollView {
            Group {
                switch vm.listState {
                case .idle:
                    Color.clear
                case .loading:
                    ProgressView("Loading...")
                case .success(let characters):
                    LazyVStack(spacing: 16) {
                        ForEach(characters) { character in
                            HStack(spacing: 12) {
                                Rectangle()
                                    .frame(width: 100, height: 100)
                                VStack(alignment: .leading) {
                                    Text(character.name)
                                        .font(.headline)
                                        .frame(
                                            maxWidth: .infinity,
                                            alignment: .leading
                                        )
                                }
                            }
                            .fixedSize(horizontal: false, vertical: true)
                            .background(.secondary.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.secondary, lineWidth: 0.2)
                            }
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
                case .failure(let message):
                    ContentUnavailableView(
                        "Error",
                        systemImage: "xmark",
                        description: Text(message)
                    )
                }
            }
            .padding(.horizontal)
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
