import Foundation

struct APIClient {
    
    func request<R: APIRequestProtocol, T: Decodable>(
        item: R,
        shouldUseTestData: Bool
    ) async throws -> T {

        #if DEBUG
        if shouldUseTestData {
            let testDataFetchRequest = FetchTestDataRequest(testDataJsonPath: item.testDataPath)
            return try testDataFetchRequest.fetchLocalTestData(responseType: T.self)
        }
        #endif

        let urlRequest = try await createURLRequest(item)

        if let cache = URLCache.shared.cachedResponse(for: urlRequest) {
            return try await self.decode(data: cache.data)
        }

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

    private func createURLRequest<R: APIRequestProtocol>(_ requestItem: R) async throws -> URLRequest {
        
        guard
            let fullPath = URL(string: requestItem.baseURL + requestItem.path)
        else {
            throw APIError.invalidRequest
        }

        var urlComponents = URLComponents()

        urlComponents.scheme = fullPath.scheme
        urlComponents.host = fullPath.host
        urlComponents.path = fullPath.path
        urlComponents.port = fullPath.port
        urlComponents.queryItems = requestItem.queryItems

        guard
            let url = urlComponents.url
        else {
            throw APIError.invalidRequest
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestItem.method.rawValue
        if .get != requestItem.method {
            urlRequest.httpBody = try requestItem.body
        }

        requestItem.headers.forEach {
            urlRequest.addValue($1, forHTTPHeaderField: $0)
        }

        return urlRequest
    }
}
