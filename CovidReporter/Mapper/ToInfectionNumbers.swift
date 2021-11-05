
struct ToAllInfectionNumbers {
    static func map(from other: InfectionNumbers) -> InfectionNumberPerDay {
        let total = other.itemList
            .map(\.npatients)
            .compactMap { Int($0) }
            .reduce(0) { $0 + $1 }

        return .init(
            infectionNumber: total,
            date: other.itemList.first?.date ?? ""
        )
    }
}

struct ToInfectionNumbersForPrefecture {
    static func map(
        from other: InfectionNumbers,
        prefecture: Prefecture
    ) -> InfectionNumberPerDay {
        .init(
            infectionNumber: Int(other.itemList.first?.npatients ?? "") ?? 0,
            date: other.itemList.first?.date ?? ""
        )
    }
}
