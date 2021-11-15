import Foundation

protocol RequestProtocol {
    associatedtype Response: Decodable
    associatedtype Parameters: Encodable
    init()
}
