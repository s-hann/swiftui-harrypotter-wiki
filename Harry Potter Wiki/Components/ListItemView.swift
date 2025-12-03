//
//  ListItem.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 02/12/25.
//

import SwiftUI

struct ListItemView: View {
    let title: String
    let image: URL?
    var action: () -> Void = {}

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                SquareImage(image: image)
                    .frame(width: 100, height: 100)
                VStack(alignment: .leading) {
                    Text(title)
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
        .buttonStyle(.plain)
    }
}

struct SquareImage: View {
    let image: URL?

    var body: some View {
        Color.clear
            .aspectRatio(1, contentMode: .fit)
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

#Preview {
    ListItemView(
        title: "1996 Gryffindor Quidditch Keeper trials spectators",
        image: nil,
        action: {}
    )
}
