import Foundation

protocol RequestProtocol {
    associatedtype Response: Decodable
    associatedtype Parameters: Encodable

    var parameters: Parameters { get }

    init(parameters: Parameters)
}
