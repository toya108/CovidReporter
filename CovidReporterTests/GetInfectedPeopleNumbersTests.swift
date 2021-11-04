import XCTest
@testable import CovidReporter

class GetInfectedPeopleNumbersTests: XCTestCase {

    func testExample() async throws {
        let result = try await Repositories.InfectedPeopleNumbers.Get().request(
            parameters: .init(date: "20211101", dataName: nil),
            shouldUseTestData: true
        )
        XCTAssertNotNil(result)
    }

}
