import Foundation

protocol APIRequestProtocol: RequestProtocol {
    var headers: [String: String] { get }
    var method: HTTPMethod { get }
    var baseURL: String { get }
    var path: String { get }

    #if DEBUG
    var testDataPath: URL? { get }
    #endif

}

extension APIRequestProtocol {

    var baseURL: String {
        "https://opendata.corona.go.jp/api/Covid19JapanAll"
    }

    func makeQueryItems(parameters: Parameters) -> [URLQueryItem]? {
        let query: [URLQueryItem]

        if let parameters = parameters as? [Encodable] {
            query = parameters.flatMap { parameter in
                parameter.dictionary.map { key, value in
                    URLQueryItem(name: key, value: value?.description ?? "")
                }
            }
        } else {
            query = parameters.dictionary.map { key, value in
                URLQueryItem(name: key, value: value?.description ?? "")
            }
        }
        return query.sorted { first, second -> Bool in
            first.name > second.name
        }
    }

    var path: String { "" }

    func makeBody(parameters: Parameters) throws -> Data {
        try JSONEncoder().encode(parameters)
    }

    var headers: [String: String] {
        return APIRequestHeader.allCases.reduce(into: [String: String]()) {
            $0[$1.rawValue] = $1.value
        }
    }

    var localDataInterceptor: (Parameters) -> Response? {{ _ in nil }}
}

private extension Encodable {
    var dictionary: [String: CustomStringConvertible?] {
        (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self)))
        as? [String: CustomStringConvertible?] ?? [:]
    }
}
