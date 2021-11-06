import Foundation

public struct DeletePrefecturesRequest: LocalRequest {
    typealias Response = EmptyResponse
    typealias Parameters = Prefecture

    var parameters: Prefecture

    func intercept(_ parameter: Prefecture) -> EmptyResponse? {
        var prefectures =  LocalDataHolder.prefectures ?? []
        prefectures.removeAll(where: { $0 == parameter.rawValue })
        LocalDataHolder.prefectures = prefectures
        return .init()
    }
}
