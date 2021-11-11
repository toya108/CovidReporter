import Foundation

struct APIClient {
    
    func request<R: APIRequestProtocol, T: Decodable>(
        request: R,
        parameters: R.Parameters,
        shouldUseTestData: Bool
    ) async throws -> T {

        #if DEBUG
        if shouldUseTestData {
            let testDataFetchRequest = FetchTestDataRequest(testDataJsonPath: request.testDataPath)
            return try testDataFetchRequest.fetchLocalTestData(responseType: T.self)
        }
        #endif

        let urlRequest = try await createURLRequest(request: request, parameters: parameters)

        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard
            let response = response as? HTTPURLResponse
        else {
            throw APIError.emptyResponse
        }

        guard
            200 ..< 300 ~= response.statusCode
        else {
            throw APIError.httpError(status: response.statusCode)
        }

        return try await decode(data: data)
    }

    private func decode<T: Decodable>(data: Data) async throws -> T {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let value = try decoder.decode(T.self, from: data)
            return value
        } catch {
            throw APIError.decodeError(error.localizedDescription)
        }
    }

    private func createURLRequest<R: APIRequestProtocol>(
        request: R,
        parameters: R.Parameters
    )async throws -> URLRequest {
        
        guard
            let fullPath = URL(string: request.baseURL + request.path)
        else {
            throw APIError.invalidRequest
        }

        var urlComponents = URLComponents()

        urlComponents.scheme = fullPath.scheme
        urlComponents.host = fullPath.host
        urlComponents.path = fullPath.path
        urlComponents.port = fullPath.port
        urlComponents.queryItems = request.makeQueryItems(parameters: parameters)

        guard
            let url = urlComponents.url
        else {
            throw APIError.invalidRequest
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        if .get != request.method {
            urlRequest.httpBody = try request.makeBody(parameters: parameters)
        }

        request.headers.forEach {
            urlRequest.addValue($1, forHTTPHeaderField: $0)
        }

        return urlRequest
    }
}
