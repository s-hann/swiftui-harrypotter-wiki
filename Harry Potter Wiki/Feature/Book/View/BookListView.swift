//
//  BookListView.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 25/11/25.
//

import SwiftUI

struct BookListView: View {
    @Environment(Router.self) private var router
    @State private var vm = BookViewModel()

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
            case .success(let books):
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(books) { book in
                            GridItemView(
                                title: book.title,
                                image: book.cover,
                                action: {
                                    router.navigateTo(
                                        route: .bookDetails(book: book)
                                    )
                                }
                            )
                        }
                        Color.clear.frame(height: 40)
                            .onAppear {
                                Task {
                                    await vm.loadNextPage()
                                }
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
        .navigationTitle(Text("Book List"))
        .task {
            if case .idle = vm.listState {
                await vm.loadBooks()
            }
        }
    }
}

#Preview {
    BookListView()
        .environment(Router())
}
