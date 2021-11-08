import XCTest
@testable import CovidReporter

class DeletePrefecturesTests: XCTestCase {

    override func setUpWithError() throws {
        UserDefaults.standard.resetAllKeys()
    }

    override func tearDownWithError() throws {
        UserDefaults.standard.resetAllKeys()
    }

    func testDeletePrefectures() throws {
        UserDefaults.standard.set(
            ["北海道", "岩手県", "山口県"],
            forKey: UserDefaultKey.prefectures.rawValue
        )
        Repositories.Prefectures.Delete().request(parameters: .hokkaido)
        let prefectures = UserDefaults.standard.object(
            forKey: UserDefaultKey.prefectures.rawValue
        ) as? [String]
        XCTAssertEqual(prefectures!, ["岩手県", "山口県"])
    }

    func testDeleteUnStoredPrefectures() throws {
        Repositories.Prefectures.Delete().request(parameters: .hokkaido)
        let prefectures = UserDefaults.standard.object(
            forKey: UserDefaultKey.prefectures.rawValue
        ) as? [String]
        XCTAssertEqual(prefectures!, [])
    }
}
