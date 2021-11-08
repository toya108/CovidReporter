import XCTest
@testable import CovidReporter

class GetInfectionNumbersTests: XCTestCase {

    func testGetInfectionNumbers() async throws {
        let result = try await Repositories.InfectionNumbers.Prefecture.Get().request(
            parameters: .init(date: "20211101", dataName: nil),
            shouldUseTestData: true
        )

        XCTAssertEqual(result.itemList.count, 47)

        let hokkaido = result.itemList.first
        XCTAssertEqual(hokkaido?.date, "2021-11-01")
        XCTAssertEqual(hokkaido?.nameJp, "北海道")
        XCTAssertEqual(hokkaido?.npatients, "60752")
    }

}
