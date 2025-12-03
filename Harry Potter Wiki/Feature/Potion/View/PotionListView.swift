//
//  PotionViews.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 29/11/25.
//

import SwiftUI

struct PotionListView: View {
    @Environment(Router.self) private var router
    @State private var vm: PotionViewModel = .init()

    var body: some View {
        Group {
            switch vm.listState {
            case .idle:
                Color.clear
            case .loading:
                ProgressView("Brewing Potions...")
            case .success(let potions):
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(potions) { potion in
                            ListItemView(
                                title: potion.name,
                                image: potion.image,
                                action: {
                                    router.navigateTo(
                                        route: .potionDetails(potion: potion)
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
                    Color.clear
                        .frame(height: 20)
                        .onAppear {
                            Task { await vm.loadNextPage() }
                        }
                        .listRowSeparator(.hidden)

                    if vm.isFetchingNextPage {
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    }
                }

            case .failure(let msg):
                ContentUnavailableView(
                    "Error",
                    systemImage: "exclamationmark.triangle",
                    description: Text(msg)
                )
            }
        }
        .navigationTitle("Potions")
        .onAppear {
            Task {
                await vm.loadPotions()
            }
        }
    }
}

#Preview {
    PotionListView()
        .environment(Router())
}
