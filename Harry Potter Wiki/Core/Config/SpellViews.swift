//
//  SpellViews.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 29/11/25.
//

import SwiftUI

struct SpellGrid: View {
    @Environment(Router.self) private var router
    let spell: Spell

    var body: some View {
        Button(action: {
            router.navigateTo(route: .spellDetails(spell: spell))
        }) {
            VStack(alignment: .leading, spacing: 8) {
                SpellImage(spell: spell)
                Text(spell.name)
                    .font(.headline)
                    .lineLimit(2)
            }
        }
    }
}

struct SpellImage: View {
    let spell: Spell

    var body: some View {
        Color.clear
            .aspectRatio(1, contentMode: .fit)
            .background(.secondary.opacity(0.2))
            .overlay {
                if let image = spell.image {
                    AsyncImage(url: image) { img in
                        img.resizable().scaledToFill()
                    } placeholder: {
                        Color.gray.opacity(0.3)
                    }
                } else {
                    Image(systemName: "wand.and.stars")
                        .font(.system(size: 32))
                        .foregroundColor(.secondary)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct SpellListView: View {
    @State private var vm = SpellViewModel()

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
    ]

    var body: some View {
        Group {
            switch vm.listState {
            case .idle:
                Color.clear
            case .loading:
                ProgressView("Loading...")
            case .success(let spells):
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(spells) { spell in
                            SpellGrid(spell: spell)
                        }
                        Color.clear.frame(height: 40)
                            .onAppear {
                                Task { await vm.loadNextPage() }
                            }
                        if vm.isFetchingNextPage {
                            ProgressView()
                        }
                    }
                    .buttonStyle(.plain)
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
        .navigationTitle(Text("Spells"))
        .task {
            if case .idle = vm.listState {
                await vm.loadSpells()
            }
        }
    }
}

struct SpellDetailView: View {
    @State private var vm: SpellViewModel = .init()

    let spell: Spell

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                SpellImage(spell: spell)
                    .frame(width: 200)
                VStack(alignment: .leading, spacing: 8) {
                    Text(spell.name)
                        .font(.title2.bold())
                    if let incantation = spell.incantation { Text("Incantation: \(incantation)") }
                    if let effect = spell.effect { Text(effect) }
                    if let light = spell.light { Text("Light: \(light)") }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal)
        }
        .navigationTitle(Text(spell.name))
    }
}

#Preview {
    SpellListView()
        .environment(Router())
}
