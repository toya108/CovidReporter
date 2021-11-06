protocol RepositoryProtocol {}

struct Repository<T: RequestProtocol>: RepositoryProtocol {}

extension Repository where T: APIRequestProtocol {

    func request(
        parameters: T.Parameters,
        shouldUseTestData: Bool = false
    ) async throws -> T.Response {
        try await APIClient().request(
            item: T(parameters: parameters),
            shouldUseTestData: shouldUseTestData
        )
    }

}

extension Repository where T: APIRequestProtocol, T.Parameters == EmptyParameters {

    func request(
        parameters: T.Parameters = .init(),
        shouldUseTestData: Bool = false
    ) async throws -> T.Response {
        try await APIClient().request(
            item: T(parameters: parameters),
            shouldUseTestData: shouldUseTestData
        )
    }

}

extension Repository where T: LocalRequest {

    @discardableResult
    func request(parameters: T.Parameters) -> T.Response? {
        let item = T(parameters: parameters)
        return item.intercept(parameters)
    }

}

extension Repository where T: LocalRequest, T.Parameters == EmptyParameters {

    @discardableResult
    func request(parameters: T.Parameters = .init()) -> T.Response? {
        let item = T(parameters: parameters)
        return item.intercept(parameters)
    }

}
