import Foundation

struct DateConverter {

    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .short
        dateFormatter.locale = Locale(identifier: "ja_JP")
        return dateFormatter
    }()

    static func convert(from date: Date) -> String {
        dateFormatter.string(from: date)
    }
}
