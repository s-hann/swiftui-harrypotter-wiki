//
//  PotionViews.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 29/11/25.
//

import SwiftUI

struct PotionGrid: View {
    @Environment(Router.self) private var router
    let potion: Potion

    var body: some View {
        Button(action: {
            router.navigateTo(route: .potionDetails(potion: potion))
        }) {
            VStack(alignment: .leading, spacing: 8) {
                PotionImage(potion: potion)
                Text(potion.name)
                    .font(.headline)
                    .lineLimit(2)
            }
        }
    }
}

struct PotionImage: View {
    let potion: Potion

    var body: some View {
        Color.clear
            .aspectRatio(1, contentMode: .fit)
            .background(.secondary.opacity(0.2))
            .overlay {
                if let image = potion.image {
                    AsyncImage(url: image) { img in
                        img.resizable().scaledToFill()
                    } placeholder: {
                        Color.gray.opacity(0.3)
                    }
                } else {
                    Image(systemName: "flask")
                        .font(.system(size: 32))
                        .foregroundColor(.secondary)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct PotionListView: View {
    @State private var vm = PotionViewModel()

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
            case .success(let potions):
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(potions) { potion in
                            PotionGrid(potion: potion)
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
        .navigationTitle(Text("Potions"))
        .task {
            if case .idle = vm.listState {
                await vm.loadPotions()
            }
        }
    }
}

struct PotionDetailView: View {
    @State private var vm: PotionViewModel = .init()

    let potion: Potion

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                PotionImage(potion: potion)
                    .frame(width: 200)
                VStack(alignment: .leading, spacing: 8) {
                    Text(potion.name)
                        .font(.title2.bold())
                    if let effect = potion.effect { Text(effect) }
                    if let ingredients = potion.ingredients, !ingredients.isEmpty {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Ingredients").font(.title3)
                            ForEach(ingredients, id: \.self) { ing in
                                Text("• \(ing)")
                            }
                        }
                        .padding(.top)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal)
        }
        .navigationTitle(Text(potion.name))
    }
}

#Preview {
    PotionListView()
        .environment(Router())
}
