
import Foundation

protocol RequestProtocol {
    associatedtype Response: Decodable
    associatedtype Parameters: Encodable

    var parameters: Parameters { get }

#if DEBUG
    var testDataPath: URL? { get }
#endif

    init(parameters: Parameters)
}
