import Foundation

struct GetAllInfectionNumbersRequest: APIRequestProtocol {
    typealias Response = [AllInfectionNumbers]
    typealias Parameters = EmptyParameters
    var method: HTTPMethod { .get }
    var baseURL: String { "https://data.corona.go.jp/converted-json/covid19japan-npatients.json" }
    var testDataPath: URL? {
        Bundle.main.url(forResource: "MockAllInfectionNumbers", withExtension: "json")
    }
}

