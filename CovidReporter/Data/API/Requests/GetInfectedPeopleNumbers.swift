import Foundation

struct GetInfectionNumbersRequest: APIRequestProtocol {
    var queryItems: [URLQueryItem]?

    typealias Response = InfectionNumbers
    var method: HTTPMethod { .get }
    var query: String? { "date" }
    var testDataPath: URL? {
        Bundle.main.url(forResource: "MockInfectionNumbers", withExtension: "json")
    }
}

extension GetInfectionNumbersRequest {
    struct Parameters: Codable {
        let date: String?
        let dataName: String?

        init(date: String? = nil, dataName: String? = nil) {
            self.date = date
            self.dataName = dataName
        }
    }
}
