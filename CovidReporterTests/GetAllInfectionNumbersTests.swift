import XCTest
@testable import CovidReporter

class GetAllInfectionNumbersTests: XCTestCase {

    func testExample() async throws {
        let result = try await Repositories.AllInfectionNumbers.Get().request(
            parameters: .init(),
            shouldUseTestData: true
        )

        XCTAssertEqual(result.count, 564)

        let latest = result.last!

        XCTAssertEqual(latest.date, "2021-11-05")
        XCTAssertEqual(latest.npatients, 1719317)
        XCTAssertEqual(latest.adpatients, 220)
    }

}
