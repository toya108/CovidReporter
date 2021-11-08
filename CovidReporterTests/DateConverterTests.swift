import XCTest
@testable import CovidReporter

class DateConverterTests: XCTestCase {

    func testConvertDateToString() throws {
        let calendar = Calendar(identifier: .gregorian)
        let date = calendar.date(from: DateComponents(year: 2021, month: 11, day: 04))!

        XCTAssertEqual(DateConverter.convert(from: date), "2021/11/04")
        XCTAssertEqual(DateConverter.convert(from: date, template: .date), "11/4")
    }

    func testConvertStringToDate() throws {
        let calendar = Calendar(identifier: .gregorian)
        let date = calendar.date(from: DateComponents(year: 2021, month: 11, day: 04))!

        XCTAssertEqual(DateConverter.convert(from: "2021-11-04"), date)
        XCTAssertEqual(DateConverter.convert(from: "2021/11/04"), date)
    }

}
