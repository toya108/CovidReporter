import XCTest
@testable import CovidReporter

class DateGeneratorTests: XCTestCase {

    func testGeneratePastDays() throws {
        let calendar = Calendar(identifier: .gregorian)
        let date = calendar.date(from: DateComponents(year: 2021, month: 11, day: 04))!
        let days = DateGenerator.generatePastDays(from: date, difference: 0, to: 3)

        let first = calendar.date(from: DateComponents(year: 2021, month: 11, day: 03))!
        let secound = calendar.date(from: DateComponents(year: 2021, month: 11, day: 02))!
        let third = calendar.date(from: DateComponents(year: 2021, month: 11, day: 01))!

        XCTAssertEqual(days, [first, secound, third])
    }

    func testGeneratePastDaysUsingDifference() throws {
        let calendar = Calendar(identifier: .gregorian)
        let date = calendar.date(from: DateComponents(year: 2021, month: 11, day: 04))!
        let days = DateGenerator.generatePastDays(from: date, difference: 3, to: 3)

        let first = calendar.date(from: DateComponents(year: 2021, month: 10, day: 31))!
        let secound = calendar.date(from: DateComponents(year: 2021, month: 10, day: 30))!
        let third = calendar.date(from: DateComponents(year: 2021, month: 10, day: 29))!

        XCTAssertEqual(days, [first, secound, third])
    }
}
