import Foundation
import Charts

struct BarChartDataSource {

    let dataEntryConvertibles: [BarChartDataEntryConvertible]

    init(dataEntryConvertibles: [BarChartDataEntryConvertible] = []) {
        self.dataEntryConvertibles = dataEntryConvertibles
    }

}

extension BarChartDataSource {

    var entries: [BarChartDataEntry] {
        dataEntryConvertibles.enumerated().map {
            .init(x: Double($0), y: $1.xData)
        }
    }

    var dateValueFormatter: DateValueFormatter {
        .init(startDate: oldestDate)
    }

    var oldestDate: Date {
        self.dataEntryConvertibles.map(\.dateForSource).min() ?? Date()
    }

    var latestDate: Date {
        self.dataEntryConvertibles.map(\.dateForSource).max() ?? Date()
    }

    var latestDateString: String {
        DateConverter.convert(from: latestDate, template: .date)
    }

    var latestAdpatients: Double {
        self.dataEntryConvertibles.first(
            where: { $0.dateForSource == latestDate }
        )?.xData ?? 0.0
    }

}
