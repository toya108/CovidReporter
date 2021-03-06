import Foundation

public struct GetPrefecturesRequest: LocalRequest {
    typealias Response = [Prefecture]
    typealias Parameters = EmptyParameters

    func intercept(_ parameter: EmptyParameters) -> [Prefecture] {
        LocalDataHolder.prefectures?.compactMap { Prefecture(rawValue: $0) } ?? []
    }
}
