//
//  HomeView.swift
//  Harry Potter Wiki
//
//  Created by Hanna Nadia Savira on 25/11/25.
//

import SwiftUI

struct HomeView: View {
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Categories
                Text("Categories")
                    .font(.title3)
                    .padding(.horizontal)
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(CategoryType.allCases, id: \.self) { type in
                        HomeGridButton(type: type)
                    }
                }
                .buttonStyle(.plain)
                .padding(.horizontal)

                // Recommendations
                Text("Top picks for you")
                    .font(.title3)
                    .padding([.horizontal, .top])
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(0..<10) { _ in
                        BookGrid(book: Book.dummyBook)
                    }
                }
                .buttonStyle(.plain)
                .padding(.horizontal)
            }
        }
        .navigationTitle(Text("Harry Potter Wiki"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct HomeGridButton: View {
    @Environment(Router.self) private var router

    var type: CategoryType

    var body: some View {
        Button(action: { router.navigateTo(route: type.properties.route) }) {
            HStack {
                Text(type.properties.label)
                Spacer()
                Image(systemName: type.properties.icon)
                    .font(.system(size: 24))
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 80)
            .background(type.properties.color.opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

#Preview {
    HomeView()
        .environment(Router())
}
