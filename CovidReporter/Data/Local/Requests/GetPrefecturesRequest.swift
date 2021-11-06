import Foundation

public struct GetPrefecturesRequest: LocalRequest {
    typealias Response = [Prefecture]
    typealias Parameters = EmptyParameters

    var parameters: EmptyParameters

    var localDataInterceptor: (EmptyParameters) -> [Prefecture]? {{ _ in
        LocalDataHolder.prefectures
    }}
}
