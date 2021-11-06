import Charts
import Foundation

final class DateValueFormatter: NSObject, AxisValueFormatter {

    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(
            fromTemplate: "Md",
            options: 0,
            locale: Locale(identifier: "ja_JP")
        )
        return dateFormatter
    }()

    private let startDate: Date

    init(startDate: Date) {
        self.startDate = startDate
    }

    func stringForValue(
        _ value: Double,
        axis: AxisBase?
    ) -> String {
        guard
            let modifiedDate = Calendar.current.date(
                byAdding: .day,
                value: Int(value),
                to: startDate
            )
        else {
            return ""
        }

        return dateFormatter.string(from: modifiedDate)
    }
}
