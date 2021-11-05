import Foundation

struct GetInfectionNumbers: RequestProtocol {
    typealias Response = InfectionNumbers
    let parameters: Parameters
    var method: HTTPMethod { .get }
    var query: String? { "date" }
    var testDataPath: URL? {
        Bundle.main.url(forResource: "MockInfectionNumbers", withExtension: "json")
    }

    init(parameters: Parameters) {
        self.parameters = parameters
    }
}

extension GetInfectionNumbers {
    struct Parameters: Codable {
        let date: String?
        let dataName: String?

        init(date: String? = nil, dataName: String? = nil) {
            self.date = date
            self.dataName = dataName
        }
    }
}
