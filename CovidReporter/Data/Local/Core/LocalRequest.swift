import Foundation

protocol LocalRequest: RequestProtocol {
    var localDataInterceptor: (Parameters) -> Response? { get }
}

extension LocalRequest {
    var testDataPath: URL? { nil }
}
