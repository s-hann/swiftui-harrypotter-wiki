import SwiftUI

struct PotionDetailView: View {
    let potion: Potion

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let image = potion.image {
                    SquareImage(image: image)
                }
                Text(potion.name)
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.leading)

                if let difficulty = potion.difficulty, !difficulty.isEmpty {
                    Label("Difficulty: \(difficulty)", systemImage: "flame")
                        .font(.headline)
                }

                if let ingredients = potion.ingredients, !ingredients.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Ingredients")
                            .font(.headline)
                        Text(ingredients)
                    }
                }

                if let effect = potion.effect, !effect.isEmpty {
                    Divider()
                    Text(effect)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                }
            }
            .padding()
        }
        .navigationTitle("Potion")
        .navigationBarTitleDisplayMode(.inline)
    }
}
