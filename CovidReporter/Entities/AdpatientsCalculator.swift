struct AdpatientsCalculator {
    static func addAdpatients(
        from infectionNumbers: [InfectionNumbers]
    ) -> [InfectionNumberPerDay] {
        infectionNumbers
            .enumerated()
            .reduce(into: [InfectionNumberPerDay]()) { array, enumeration in

                guard
                    let item = enumeration.element.itemList.first,
                    infectionNumbers.indices.contains(enumeration.offset - 1),
                    let previousItem = infectionNumbers[enumeration.offset - 1].itemList.first
                else {
                    return
                }

                let perDay: InfectionNumberPerDay = .init(
                    infectionNumber: Int(item.npatients) ?? 0,
                    adpatients: (Int(item.npatients) ?? 0) - (Int(previousItem.npatients) ?? 0),
                    date: item.date
                )
                array.append(perDay)
            }
    }
}
