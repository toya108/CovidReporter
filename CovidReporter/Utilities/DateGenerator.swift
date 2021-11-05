import Foundation

struct DateGenerator {

    static let calendar = Calendar(identifier: .gregorian)

    static func generatePastDays(from date: Date, to: Int) -> [Date] {
        return (1...to).compactMap {
            calendar.date(byAdding: .day, value: -$0, to: date)
        }
    }

}
