struct BarChartDataSource {
    let dataEntryConvertibles: [BarChartDataEntryConvertible]

    init(dataEntryConvertibles: [BarChartDataEntryConvertible] = []) {
        self.dataEntryConvertibles = dataEntryConvertibles
    }

    var dateValueFormatter: DateValueFormatter {
        .init(startDate: dataEntryConvertibles.oldestDate)
    }

    var latestDate: String {
        DateConverter.convert(from: dataEntryConvertibles.latestDate, template: .date)
    }

    var latestAdpatients: Double {
        self.dataEntryConvertibles.last?.yData ?? 0.0
    }

    var values: [Double] {
        self.dataEntryConvertibles.map(\.yData)
    }

    var dateStrings: [String] {
        self.dataEntryConvertibles.map {
            DateConverter.convert(from: $0.dateForSource, template: .date)
        }
    }
}
