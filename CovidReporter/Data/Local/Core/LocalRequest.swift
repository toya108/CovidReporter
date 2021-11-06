import Foundation

protocol LocalRequest: RequestProtocol {
    var localDataInterceptor: (Parameters) -> Response? { get }
}
