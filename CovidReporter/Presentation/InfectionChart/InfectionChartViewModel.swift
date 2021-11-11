import Foundation
import Combine
import Charts

final class InfectionChartViewModel: ObservableObject {

    @Published var state: LoadingState<BarChartDataSource> = .standby

    let getInfectionNumbersRepository: Repositories.InfectionNumbers.Prefecture.Get
    let getAllInfectionNumbersRepository: Repositories.InfectionNumbers.All.Get

    init(
        getInfectionNumbersRepository: Repositories.InfectionNumbers.Prefecture.Get,
        getAllInfectionNumbersRepository: Repositories.InfectionNumbers.All.Get
    ) {
        self.getInfectionNumbersRepository = getInfectionNumbersRepository
        self.getAllInfectionNumbersRepository = getAllInfectionNumbersRepository
    }

    @MainActor func fetchInfectionNumbers(prefecture: Prefecture) async {

        self.state = .loading

        do {
            let sources = prefecture == .all
                ? try await fetchAllInfectionNumbers()
                : try await fetchInfectionNumbers(per: prefecture)
            self.state = .finished(.init(dataEntryConvertibles: sources))
        } catch {
            self.state = .failed(error)
        }
    }

    private func fetchAllInfectionNumbers() async throws -> [BarChartDataEntryConvertible] {
        let infectionNumbers = try await getAllInfectionNumbersRepository.request()
        return Array(infectionNumbers.suffix(7))
    }

    private func fetchInfectionNumbers(
        per prefecture: Prefecture
    ) async throws -> [BarChartDataEntryConvertible] {
        let infectionNumbers = try await getInfectionNumbersRepository.request(
            parameters: .init(dataName: prefecture.rawValue)
        )
        let eightDays = Array(infectionNumbers.itemList.prefix(8).reversed())
        return AdpatientsCalculator.addAdpatients(from: eightDays)
    }
}
