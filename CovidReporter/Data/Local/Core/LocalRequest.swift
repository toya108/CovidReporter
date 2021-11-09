import Foundation

protocol LocalRequest: RequestProtocol {
    func intercept(_ prameters: Parameters) -> Response
}
