import Foundation
import Combine

final class ChartListViewModel: ObservableObject {

    @Published var prefectures: [Prefecture] = []
    @Published var shouldShowSelectPrefecture = false

    let getPrefecturesRepository: Repositories.Prefectures.Get
    let setPrefecturesRepository: Repositories.Prefectures.Set
    let deletePrefecturesRepository: Repositories.Prefectures.Delete

    init(
        getPrefecturesRepository: Repositories.Prefectures.Get,
        setPrefecturesRepository: Repositories.Prefectures.Set,
        deletePrefecturesRepository: Repositories.Prefectures.Delete
    ) {
        self.getPrefecturesRepository = getPrefecturesRepository
        self.setPrefecturesRepository = setPrefecturesRepository
        self.deletePrefecturesRepository = deletePrefecturesRepository
    }

    func updatePrefectures() {
        self.prefectures = [.all] + (getPrefecturesRepository.request() ?? [])
    }

    func set(prefecture: Prefecture) {
        self.setPrefecturesRepository.request(parameters: prefecture)
    }

    func delete(prefecture: Prefecture) {
        self.deletePrefecturesRepository.request(parameters: prefecture)
    }

}
