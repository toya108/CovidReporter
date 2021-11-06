import Foundation

struct DateGenerator {

    private static let calendar = Calendar(identifier: .gregorian)

    static func generatePastDays(from date: Date, difference: Int, to: Int) -> [Date] {

        guard let pastDay = generatePastDay(from: date, to: difference) else {
            return []
        }

        return (1...to).compactMap {
            calendar.date(byAdding: .day, value: -$0, to: pastDay)
        }
    }

    private static func generatePastDay(from date: Date, to: Int) -> Date? {
        calendar.date(byAdding: .day, value: -to, to: date)
    }

}
