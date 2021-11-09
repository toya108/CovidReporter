import Charts
import Foundation

protocol BarChartDataEntryConvertible {
    var dateForSource: Date { get }
    var xData: Double { get }
}

extension AllInfectionNumbers: BarChartDataEntryConvertible {
    var dateForSource: Date {
        DateConverter.convert(from: self.date)
    }

    var xData: Double {
        Double(self.adpatients)
    }
}

extension InfectionNumberPerDay: BarChartDataEntryConvertible {
    var dateForSource: Date {
        DateConverter.convert(from: self.date)
    }

    var xData: Double {
        Double(self.adpatients)
    }
}
