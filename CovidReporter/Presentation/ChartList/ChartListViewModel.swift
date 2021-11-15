import Foundation
import Combine

final class ChartListViewModel: ObservableObject {

    @Published var prefectures: [Prefecture] = []
    @Published var shouldShowSelectPrefecture = false

    let getPrefecturesRepository: AnyRepository<GetPrefecturesRequest>
    let setPrefecturesRepository: AnyRepository<SetPrefecturesRequest>
    let deletePrefecturesRepository: AnyRepository<DeletePrefecturesRequest>

    init(
        getPrefecturesRepository: AnyRepository<GetPrefecturesRequest>,
        setPrefecturesRepository: AnyRepository<SetPrefecturesRequest>,
        deletePrefecturesRepository: AnyRepository<DeletePrefecturesRequest>
    ) {
        self.getPrefecturesRepository = getPrefecturesRepository
        self.setPrefecturesRepository = setPrefecturesRepository
        self.deletePrefecturesRepository = deletePrefecturesRepository
    }

    func updatePrefectures() {
        self.prefectures = [.all] + (getPrefecturesRepository.request())
    }

    func set(prefecture: Prefecture) {
        self.setPrefecturesRepository.request(parameters: prefecture)
    }

    func delete(prefecture: Prefecture) {
        self.deletePrefecturesRepository.request(parameters: prefecture)
    }

}
