//
//  BookDetailView.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 29/11/25.
//

import SwiftUI

struct BookDetailView: View {
    @State private var vm: BookViewModel = .init()

    let book: Book

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                BookCover(book: book)
                    .frame(width: 200)
                VStack(alignment: .leading, spacing: 8) {
                    Text(book.title)
                        .font(.title2.bold())
                    if let author = book.author {
                        Text("By \(author)")
                    }
                    if let releaseDate = book.releaseDate {
                        Text("Published: \(releaseDate)")
                    }
                    if let summary = book.summary {
                        Text(summary)
                    }

                    VStack {
                        switch vm.chaptersState {
                        case .idle:
                            Color.clear
                        case .loading:
                            ProgressView("Loading chapters...")
                        case .success(let chapters):
                            LazyVStack(alignment: .leading, spacing: 8) {
                                Text("Chapters")
                                    .font(.title3)
                                ForEach(chapters) { chapter in
                                    if let chTitle = chapter.title {
                                        Text("\(chapter.order): \(chTitle)")
                                            .frame(
                                                maxWidth: .infinity,
                                                alignment: .leading
                                            )
                                            .multilineTextAlignment(.leading)
                                            .padding()
                                            .background(
                                                RoundedRectangle(
                                                    cornerRadius: 12
                                                ).foregroundStyle(
                                                    .red.opacity(0.1)
                                                )
                                            )
                                    }
                                }
                            }
                            .padding(.top)
                        case .failure(let message):
                            ContentUnavailableView(
                                "Error",
                                systemImage: "xmark",
                                description: Text(message)
                            )
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal)
        }
        .navigationTitle(Text(book.title))
        .task {
            if case .idle = vm.listState {
                await vm.loadChapters(bookId: book.id)
            }
        }
    }
}

#Preview {
    BookDetailView(book: Book.dummyBook)
}
