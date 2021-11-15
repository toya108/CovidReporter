import Foundation

struct DateConverter {

    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .short
        dateFormatter.locale = Locale(identifier: "ja_JP")
        return dateFormatter
    }()

    static func convert(from date: Date, template: DateFormatter.Template? = nil) -> String {
        if let template = template {
            dateFormatter.set(template: template)
        } else {
            dateFormatter.dateFormat = nil
        }
        return dateFormatter.string(from: date)
    }

    static func convert(from string: String) -> Date {
        dateFormatter.dateFormat = nil
        return dateFormatter.date(from: string) ?? Date()
    }
}

extension DateFormatter {
    enum Template: String {
        case date = "Md"
    }

    func set(template: Template) {
        dateFormat = DateFormatter.dateFormat(
            fromTemplate: template.rawValue,
            options: 0,
            locale: Locale(identifier: "ja_JP")
        )
    }
}
