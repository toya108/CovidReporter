import Foundation

struct FetchTestDataRequest {

    private let testDataJsonPath: URL?

    init(testDataJsonPath: URL?) {
        self.testDataJsonPath = testDataJsonPath
    }

    func fetchLocalTestData<T: Decodable>(responseType: T.Type) throws -> T {
        guard
            let url = testDataJsonPath
        else {
            throw APIError.missingTestJsonDataPath
        }

        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let result = try decoder.decode(T.self, from: data)
        return result
    }
}
