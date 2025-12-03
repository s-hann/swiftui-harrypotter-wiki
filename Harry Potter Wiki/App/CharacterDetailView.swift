import SwiftUI

struct CharacterDetailView: View {
    let character: Character

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let image = character.image {
                    SquareImage(image: image)
                }
                Text(character.name)
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.leading)

                if let house = character.house, !house.isEmpty {
                    Label(house, systemImage: "house")
                        .font(.headline)
                }

                if let patronus = character.patronus, !patronus.isEmpty {
                    Label("Patronus: \(patronus)", systemImage: "sparkles")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .padding()
        }
        .navigationTitle("Character")
        .navigationBarTitleDisplayMode(.inline)
    }
}
