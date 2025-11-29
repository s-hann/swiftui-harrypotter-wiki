//
//  BookCover.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 29/11/25.
//

import SwiftUI

struct BookGrid: View {
    @Environment(Router.self) private var router
    let book: Book

    var body: some View {
        Button(action: {
            router.navigateTo(route: .bookDetails(book: book))
        }) {
            VStack(alignment: .leading, spacing: 8) {
                BookCover(book: book)
                Text(book.title)
                    .font(.headline)
                    .lineLimit(2)
            }
        }
    }
}

struct BookCover: View {
    let book: Book

    var body: some View {
        Color.clear
            .aspectRatio(2 / 3, contentMode: .fit)
            .background(.secondary.opacity(0.2))
            .overlay {
                if let image = book.cover {
                    AsyncImage(url: image) { img in
                        img.resizable().scaledToFill()
                    } placeholder: {
                        Color.gray.opacity(0.3)
                    }
                } else {
                    Image(
                        systemName:
                            "photo.trianglebadge.exclamationmark"
                    )
                    .font(.system(size: 32))
                    .foregroundColor(.secondary)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
