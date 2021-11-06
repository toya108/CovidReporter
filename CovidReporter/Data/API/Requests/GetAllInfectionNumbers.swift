import Foundation

struct GetAllInfectionNumbers: RequestProtocol {
    typealias Response = [AllInfectionNumbers]
    typealias Parameters = EmptyParameters
    let parameters: EmptyParameters
    var method: HTTPMethod { .get }
    var baseURL: String { "https://data.corona.go.jp/converted-json/covid19japan-npatients.json" }
    var testDataPath: URL? {
        Bundle.main.url(forResource: "MockAllInfectionNumbers", withExtension: "json")
    }

    init(parameters: Parameters = .init()) {
        self.parameters = parameters
    }
}

