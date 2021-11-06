import Charts
import Foundation

protocol BarChartDataEntryConvertible {
    var dateForSource: Date { get }
    var yData: Double { get }
}

extension Array where Element == BarChartDataEntryConvertible {
    var oldestDate: Date {
        self.first?.dateForSource ?? Date()
    }

    var latestDate: Date {
        self.last?.dateForSource ?? Date()
    }

    var entries: [BarChartDataEntry] {
        enumerated().map { .init(x: Double($0), y: $1.yData) }
    }
}

extension AllInfectionNumbers: BarChartDataEntryConvertible {
    var dateForSource: Date {
        DateConverter.convert(from: self.date)
    }

    var yData: Double {
        Double(self.adpatients)
    }
}

extension InfectionNumberPerDay: BarChartDataEntryConvertible {
    var dateForSource: Date {
        DateConverter.convert(from: self.date)
    }

    var yData: Double {
        Double(self.adpatients)
    }
}
