import XCTest
@testable import CovidReporter

class SetPrefecturesTests: XCTestCase {

    override func setUpWithError() throws {
        UserDefaults.standard.resetAllKeys()
    }

    override func tearDownWithError() throws {
        UserDefaults.standard.resetAllKeys()
    }

    func testSetPrefectures() throws {
        Repositories.Prefectures.Set().request(parameters: .aichi)
        let prefectures = UserDefaults.standard.object(
            forKey: UserDefaultKey.prefectures.rawValue
        ) as? [String]
        XCTAssertEqual(prefectures!, ["愛知県"])
    }
}
