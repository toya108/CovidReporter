import Foundation

struct InfectionNumbers: Codable, Hashable {
    let itemList: [Item]
}

extension InfectionNumbers {

    struct ErrorInfo: Codable, Hashable {
        let errorFlag: Int
        let errorCode: String?
        let errorMessage: String?
    }

    struct Item: Codable, Hashable {
        let date: String
        let nameJp: String
        let npatients: String
    }
}
