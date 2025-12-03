import SwiftUI

struct MovieDetailView: View {
    let movie: Movie

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let poster = movie.poster {
                    PortraitImage(image: poster)
                }

                Text(movie.title)
                    .font(.title)
                    .bold()

                HStack {
                    if let releaseDate = movie.releaseDate { Text(releaseDate) }
                    Spacer()
                    if let rating = movie.rating { Text(rating) }
                    Spacer()
                    if let runningTime = movie.runningTime {
                        Text(runningTime)
                    }
                }
                .font(.subheadline)
                .foregroundColor(.secondary)

//                if let summary = movie.summary {
//                    VStack(alignment: .leading, spacing: 8) {
//                        Text("Summary")
//                            .font(.headline)
//                        Text(summary)
//                    }
//                }

//                if let director = movie.director, !director.isEmpty {
//                    Label(director, systemImage: "person.fill")
//                        .font(.subheadline)
//                        .foregroundStyle(.secondary)
//                }

                if let budget = movie.budget, !budget.isEmpty {
                    Label("Budget: \(budget)", systemImage: "banknote")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                if let boxOffice = movie.boxOffice, !boxOffice.isEmpty {
                    Label(
                        "Box Office: \(boxOffice)",
                        systemImage: "dollarsign.circle"
                    )
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                }

                if let trailer = movie.trailer {
                    Link("Watch Trailer", destination: trailer)
                        .font(.headline)
                        .foregroundColor(.blue)
                }
            }
            .padding()
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(
            movie: Movie(
                id: "1",
                title: "Harry Potter and the Sorcerer's Stone",
                summary:
                    "Harry discovers he is a wizard and attends Hogwarts School of Witchcraft and Wizardry.",
                releaseDate: "2001-11-16",
                rating: "PG",
                runningTime: "152 min",
                budget: "$125 million",
                boxOffice: "$1.02 billion",
                poster: nil,
                trailer: nil
            )
        )
    }
}
