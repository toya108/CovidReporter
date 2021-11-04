protocol RepositoryProtocol {

    associatedtype T: RequestProtocol

    func request(
        parameters: T.Parameters,
        shouldUseTestData: Bool
    ) async throws -> T.Response
}

struct Repository<T: RequestProtocol>: RepositoryProtocol {

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
