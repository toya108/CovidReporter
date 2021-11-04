import Foundation

struct GetInfectedPeopleNumbers: RequestProtocol {
    typealias Response = InfectedPeopleNumbers
    let parameters: Parameters
    var method: HTTPMethod { .get }
    var query: String? { "date" }
    var testDataPath: URL? {
        Bundle.main.url(forResource: "MockInfectedPeopleNumbers", withExtension: "json")
    }

    init(parameters: Parameters) {
        self.parameters = parameters
    }
}

extension GetInfectedPeopleNumbers {
    struct Parameters: Codable {
        let date: String?
        let dataName: String?
    }
}
