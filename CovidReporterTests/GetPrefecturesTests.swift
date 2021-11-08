import XCTest
@testable import CovidReporter

class GetPrefecturesTests: XCTestCase {

    override func setUpWithError() throws {
        UserDefaults.standard.resetAllKeys()
    }

    override func tearDownWithError() throws {
        UserDefaults.standard.resetAllKeys()
    }

    func testGetPrefectures() throws {
        UserDefaults.standard.set(
            ["北海道", "岩手県", "山口県"],
            forKey: UserDefaultKey.prefectures.rawValue
        )
        let prefectures = Repositories.Prefectures.Get().request()
        XCTAssertEqual(prefectures, ["北海道", "岩手県", "山口県"].compactMap { .init(rawValue: $0) })
    }

    func testGetPrefecturesWhileEmpty() throws {
        UserDefaults.standard.set(
            [],
            forKey: UserDefaultKey.prefectures.rawValue
        )
        let prefectures = Repositories.Prefectures.Get().request()
        XCTAssertEqual(prefectures, [].compactMap { .init(rawValue: $0) })
    }

    func testGetPrefecturesDefaultValue() throws {
        let prefectures = Repositories.Prefectures.Get().request()
        XCTAssertEqual(prefectures, [].compactMap { .init(rawValue: $0) })
    }
}
