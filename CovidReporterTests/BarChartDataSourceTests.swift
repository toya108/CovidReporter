import XCTest
@testable import CovidReporter
@testable import Charts

class BarChartDataSourceTests: XCTestCase {

    func testBarChartDataSource() throws {

        let allInfectionNumbers: [AllInfectionNumbers] = [
            .init(date: "2021-11-01", npatients: 100, adpatients: 100),
            .init(date: "2021-11-02", npatients: 200, adpatients: 100),
            .init(date: "2021-11-03", npatients: 300, adpatients: 100),
            .init(date: "2021-11-04", npatients: 400, adpatients: 100),
            .init(date: "2021-11-05", npatients: 500, adpatients: 100),
            .init(date: "2021-11-06", npatients: 800, adpatients: 300)
        ]

        let dataSource = BarChartDataSource(dataEntryConvertibles: allInfectionNumbers)

        let calendar = Calendar(identifier: .gregorian)
        let latestDate = calendar.date(from: DateComponents(year: 2021, month: 11, day: 06))!
        XCTAssertEqual(dataSource.latestDate, latestDate)
        XCTAssertEqual(dataSource.latestDateString, "11/6")
        XCTAssertEqual(dataSource.latestAdpatients, 300)


        let oldestDate = calendar.date(from: DateComponents(year: 2021, month: 11, day: 01))!
        XCTAssertEqual(dataSource.oldestDate, oldestDate)

        let entries: [BarChartDataEntry] = [
            .init(x: 0, y: 100),
            .init(x: 1, y: 100),
            .init(x: 2, y: 100),
            .init(x: 3, y: 100),
            .init(x: 4, y: 100),
            .init(x: 5, y: 300)
        ]
        XCTAssertEqual(dataSource.entries, entries)
    }
}
