import Foundation

struct GetInfectedPeopleNumbers: RequestProtocol {
    typealias Response = InfectedPeopleNumbers
    let parameters: Parameters
    var method: HTTPMethod { .get }
    var query: String? { "date" }

    init(parameters: Parameters) {
        self.parameters = parameters
    }
}

extension GetInfectedPeopleNumbers {
    struct Parameters: Codable {
        let date: String
        let dataName: String
    }
}
