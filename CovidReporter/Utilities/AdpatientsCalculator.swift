struct AdpatientsCalculator {
    static func addAdpatients(
        from itemList: [InfectionNumbers.Item]
    ) -> [InfectionNumberPerDay] {
        itemList
            .enumerated()
            .reduce(into: [InfectionNumberPerDay]()) { array, enumeration in

                let previousOffset = enumeration.offset - 1
                guard
                    itemList.indices.contains(previousOffset)
                else {
                    return
                }

                let perDay: InfectionNumberPerDay = .init(
                    infectionNumber: Int(enumeration.element.npatients) ?? 0,
                    adpatients: (Int(enumeration.element.npatients) ?? 0) - (Int(itemList[previousOffset].npatients) ?? 0),
                    date: enumeration.element.date
                )
                array.append(perDay)
            }
    }
}
