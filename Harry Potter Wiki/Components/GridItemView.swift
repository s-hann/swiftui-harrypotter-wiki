//
//  BookCover.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 29/11/25.
//

import SwiftUI

struct GridItemView: View {
    let title: String
    let image: URL?
    var action: () -> Void = {}

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                PortraitImage(image: image)
                Text(title)
                    .font(.headline)
                    .lineLimit(2)
            }
        }
        .buttonStyle(.plain)
    }
}

struct PortraitImage: View {
    let image: URL?

    var body: some View {
        Color.clear
            .aspectRatio(2 / 3, contentMode: .fit)
            .background(.secondary.opacity(0.2))
            .overlay {
                if let image = self.image {
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
