import XCTest
@testable import CovidReporter

class AdpatientsCalculatorTests: XCTestCase {

    func testAddAdatients() throws {
        let sources: [InfectionNumbers] = [
            .init(itemList: [.init(date: "2021-11-01", nameJp: "北海道", npatients: "1000")]),
            .init(itemList: [.init(date: "2021-11-02", nameJp: "北海道", npatients: "2000")]),
            .init(itemList: [.init(date: "2021-11-03", nameJp: "北海道", npatients: "3000")]),
            .init(itemList: [.init(date: "2021-11-04", nameJp: "北海道", npatients: "4000")]),
            .init(itemList: [.init(date: "2021-11-05", nameJp: "北海道", npatients: "5000")])
        ]

        let infectionNumbersPerDay = AdpatientsCalculator.addAdpatients(from: sources)

        XCTAssertEqual(infectionNumbersPerDay[0].adpatients, 1000)
        XCTAssertEqual(infectionNumbersPerDay[0].date, "2021-11-02")
        XCTAssertEqual(infectionNumbersPerDay[0].infectionNumber, 2000)

        XCTAssertEqual(infectionNumbersPerDay[1].adpatients, 1000)
        XCTAssertEqual(infectionNumbersPerDay[1].date, "2021-11-03")
        XCTAssertEqual(infectionNumbersPerDay[1].infectionNumber, 3000)

        XCTAssertEqual(infectionNumbersPerDay[2].adpatients, 1000)
        XCTAssertEqual(infectionNumbersPerDay[2].date, "2021-11-04")
        XCTAssertEqual(infectionNumbersPerDay[2].infectionNumber, 4000)

        XCTAssertEqual(infectionNumbersPerDay[3].adpatients, 1000)
        XCTAssertEqual(infectionNumbersPerDay[3].date, "2021-11-05")
        XCTAssertEqual(infectionNumbersPerDay[3].infectionNumber, 5000)
    }

}
