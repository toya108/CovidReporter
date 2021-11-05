import Foundation

struct InfectionNumberForPrefecture: Identifiable {
    let id = UUID().uuidString
    let prefecture: Prefecture
    var infectionNumberPerDay: [InfectionNumberPerDay]
}

struct InfectionNumberPerDay {
    let infectionNumber: Int
    let date: String
}

