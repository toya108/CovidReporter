import Foundation

struct InfectedPeopleNumbers: Codable, Hashable {
    let itemList: [Item]
}

extension InfectedPeopleNumbers {

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
