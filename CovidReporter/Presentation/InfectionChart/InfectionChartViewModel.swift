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

    func fetchInfectionNumbers(prefecture: Prefecture) async {

        self.state = .loading

        prefecture == .all
        ? await fetchAllInfectionNumbers()
        : await fetchInfectionNumbers(per: prefecture)
    }

    private func fetchAllInfectionNumbers() async {

        do {
            let infectionNumbers = try await getAllInfectionNumbersRepository.request()
            let latest = Array(infectionNumbers.suffix(7))
            self.state = .finished(.init(dataEntryConvertibles: latest))
        } catch {
            self.state = .failed(error)
        }
    }

    private func fetchInfectionNumbers(per prefecture: Prefecture) async {

        let days = DateGenerator.generatePastDays(from: Date(), difference: 1, to: 8).map {
            DateConverter.convert(from: $0).filter { $0 != "/" }
        }

        do {
            async let first = self.getInfectionNumbersRepository.request(
                parameters: .init(date: days[0], dataName: prefecture.rawValue)
            )
            async let second = self.getInfectionNumbersRepository.request(
                parameters: .init(date: days[1], dataName: prefecture.rawValue)
            )
            async let third = self.getInfectionNumbersRepository.request(
                parameters: .init(date: days[2], dataName: prefecture.rawValue)
            )
            async let fourth = self.getInfectionNumbersRepository.request(
                parameters: .init(date: days[3], dataName: prefecture.rawValue)
            )
            async let fifth = self.getInfectionNumbersRepository.request(
                parameters: .init(date: days[4], dataName: prefecture.rawValue)
            )
            async let sixth = self.getInfectionNumbersRepository.request(
                parameters: .init(date: days[5], dataName: prefecture.rawValue)
            )
            async let seventh = self.getInfectionNumbersRepository.request(
                parameters: .init(date: days[6], dataName: prefecture.rawValue)
            )
            async let eigth = self.getInfectionNumbersRepository.request(
                parameters: .init(date: days[7], dataName: prefecture.rawValue)
            )

            let infectionNumbers = try await [
                eigth, seventh, sixth, fifth, fourth, third, second, first
            ]
            let dataEntryConvertibles = AdpatientsCalculator.addAdpatients(from: infectionNumbers)
            DispatchQueue.main.async { [weak self] in
                
                guard let self = self else { return }

                self.state = .finished(.init(dataEntryConvertibles: dataEntryConvertibles))
            }

        } catch {
            self.state = .failed(error)
        }
    }

}
