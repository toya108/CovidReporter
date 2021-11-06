import Foundation

public struct GetPrefecturesRequest: LocalRequest {
    typealias Response = [Prefecture]
    typealias Parameters = EmptyParameters

    var localDataInterceptor: (EmptyParameters) -> [Prefecture]? {{ _ in
        LocalDataHolder.prefectures
    }}

    init(parameters: EmptyParameters) {}
}
