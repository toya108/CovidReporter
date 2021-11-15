struct Repositories {
    struct InfectionNumbers {
        struct All {
            struct Get: RepositoryProtocol {
                typealias R = GetAllInfectionNumbersRequest
            }
            struct GetMock: RepositoryProtocol {
                typealias R = GetAllInfectionNumbersRequest
                func request(parameters: EmptyParameters) async throws -> [AllInfectionNumbers] {
                    try await APIClient().request(
                        request: R(),
                        parameters: EmptyParameters(),
                        shouldUseTestData: true
                    )
                }
            }
        }
        struct Prefecture {
            struct Get: RepositoryProtocol {
                typealias R = GetInfectionNumbersRequest
            }
            struct GetMock: RepositoryProtocol {
                typealias R = GetInfectionNumbersRequest
                func request(parameters: EmptyParameters) async throws -> [AllInfectionNumbers] {
                    try await APIClient().request(
                        request: R(),
                        parameters: .init(date: nil, dataName: nil),
                        shouldUseTestData: true
                    )
                }
            }
        }
    }
    struct Prefectures {
        struct Get: RepositoryProtocol {
            typealias R = GetPrefecturesRequest
        }
        struct Set: RepositoryProtocol {
            typealias R = SetPrefecturesRequest
        }
        struct Delete: RepositoryProtocol {
            typealias R = DeletePrefecturesRequest
        }
    }
}
