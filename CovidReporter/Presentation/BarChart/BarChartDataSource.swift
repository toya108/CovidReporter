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
}
