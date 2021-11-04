import Foundation

public enum APIError: LocalizedError {
    case unknown
    case invalidRequest
    case responseError(Error)
    case httpError(status: Int)
    case offline
    case decodeError(String)
    case emptyResponse

    public var errorDescription: String? {
        switch self {
            case .unknown:
                return "unknown error occured"

            case .invalidRequest:
                return "invalid request"

            case let .responseError(error):
                return "response error occured, error: \(error.localizedDescription)"

            case let .httpError(status):
                return "http error occured, status: \(status)"

            case .offline:
                return "offline error occured"

            case let .decodeError(error):
                return "decode error occured, \(error)"

            case .emptyResponse:
                return "empty response error occured"
        }
    }
}
