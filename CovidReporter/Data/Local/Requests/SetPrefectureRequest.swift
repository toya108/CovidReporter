import Foundation

public struct SetPrefecturesRequest: LocalRequest {
    typealias Response = EmptyResponse
    typealias Parameters = Prefecture

    func intercept(_ parameter: Prefecture) -> EmptyResponse {
        var prefectures = LocalDataHolder.prefectures ?? []
        prefectures.append(parameter.rawValue)
        LocalDataHolder.prefectures = prefectures
        return .init()
    }
}
